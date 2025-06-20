import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class FuelFlowBluetoothService {
  static final FuelFlowBluetoothService _instance =
      FuelFlowBluetoothService._internal();
  factory FuelFlowBluetoothService() => _instance;
  FuelFlowBluetoothService._internal();

  StreamController<List<ScanResult>>? _devicesController;
  Stream<List<ScanResult>>? _devicesStream;
  final List<ScanResult> _discoveredDevices = [];
  bool _isScanning = false;

  Stream<List<ScanResult>> get devicesStream {
    _devicesController ??= StreamController<List<ScanResult>>.broadcast();
    _devicesStream ??= _devicesController!.stream;
    return _devicesStream!;
  }

  bool get isScanning => _isScanning;

  Future<bool> checkBluetoothPermissions() async {
    if (Platform.isAndroid) {
      // Check for required permissions on Android
      Map<Permission, PermissionStatus> statuses =
          await [
            Permission.bluetooth,
            Permission.bluetoothScan,
            Permission.bluetoothConnect,
            Permission.bluetoothAdvertise,
            Permission.location,
          ].request();

      return statuses.values.every(
        (status) =>
            status == PermissionStatus.granted ||
            status == PermissionStatus.limited,
      );
    } else if (Platform.isIOS) {
      // Check for required permissions on iOS
      var bluetoothStatus = await Permission.bluetooth.request();
      return bluetoothStatus == PermissionStatus.granted;
    }
    return false;
  }

  Future<bool> isBluetoothOn() async {
    try {
      return await FlutterBluePlus.adapterState.first ==
          BluetoothAdapterState.on;
    } catch (e) {
      debugPrint('Error checking Bluetooth state: $e');
      return false;
    }
  }

  Future<void> enableBluetooth() async {
    try {
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
      }
    } catch (e) {
      debugPrint('Error enabling Bluetooth: $e');
      rethrow;
    }
  }

  Future<List<BluetoothDevice>> scanForDevices({
    Duration timeout = const Duration(seconds: 10),
    List<String>? serviceUuids,
  }) async {
    try {
      // Check permissions
      if (!await checkBluetoothPermissions()) {
        throw Exception('Bluetooth permissions not granted');
      }

      // Check if Bluetooth is enabled
      if (!await isBluetoothOn()) {
        throw Exception('Bluetooth is not enabled');
      }

      // Clear previous results
      _discoveredDevices.clear();
      _isScanning = true;

      // Start scanning
      await FlutterBluePlus.startScan(
        timeout: timeout,
        androidUsesFineLocation: true,
      );

      // Listen to scan results
      StreamSubscription? scanSubscription;
      scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        _discoveredDevices.clear();

        for (ScanResult result in results) {
          // Filter for devices that might be OBD-II adapters
          if (_isLikelyOBDDevice(result.device, result.advertisementData)) {
            if (!_discoveredDevices.any(
              (d) => d.device.remoteId == result.device.remoteId,
            )) {
              _discoveredDevices.add(result);
            }
          }
        }

        // Update stream
        _devicesController?.add(_discoveredDevices);
      });

      // Wait for scan to complete
      await Future.delayed(timeout);

      // Stop scanning
      await FlutterBluePlus.stopScan();
      scanSubscription.cancel();
      _isScanning = false;

      // Return just the devices
      return _discoveredDevices.map((result) => result.device).toList();
    } catch (e) {
      _isScanning = false;
      debugPrint('Error scanning for devices: $e');
      rethrow;
    }
  }

  bool _isLikelyOBDDevice(BluetoothDevice device, AdvertisementData adData) {
    final deviceName = device.platformName.toLowerCase();
    final localName = adData.advName.toLowerCase();

    // Common OBD-II device name patterns
    final obdPatterns = [
      'elm327',
      'obd',
      'obdii',
      'obd-ii',
      'obd2',
      'vgate',
      'icar',
      'torque',
      'scan',
      'diag',
      'automotive',
      'car',
      'vehicle',
      'ecu',
      'bluetooth',
    ];

    // Check device name
    for (String pattern in obdPatterns) {
      if (deviceName.contains(pattern) || localName.contains(pattern)) {
        return true;
      }
    }

    // Include devices with unknown names (many OBD adapters don't advertise names)
    if (deviceName.isEmpty && localName.isEmpty) {
      return true;
    }

    // Include devices that advertise serial port service (common for OBD)
    final serviceUuids = adData.serviceUuids.map(
      (uuid) => uuid.toString().toLowerCase(),
    );
    for (String uuid in serviceUuids) {
      if (uuid.contains('1101') || // Serial Port Profile
          uuid.contains('1106') || // OBEX Object Push
          uuid.contains('00001101')) {
        // SPP UUID
        return true;
      }
    }

    return false;
  }

  /// Get the best available name for a Bluetooth device
  String getDeviceName(BluetoothDevice device, {AdvertisementData? adData}) {
    // Try platform name first
    if (device.platformName.isNotEmpty) {
      return device.platformName;
    }

    // Try advertisement name if available
    if (adData?.advName.isNotEmpty == true) {
      return adData!.advName;
    }

    // Check for common OBD device patterns and provide meaningful names
    final address = device.remoteId.toString();

    // Generate a meaningful name based on device characteristics
    if (adData != null) {
      // Check service UUIDs for hints
      final serviceUuids = adData.serviceUuids.map(
        (uuid) => uuid.toString().toLowerCase(),
      );
      for (String uuid in serviceUuids) {
        if (uuid.contains('1101') || uuid.contains('00001101')) {
          return 'OBD-II Device (SPP)';
        }
      }
    }

    // Generate name based on MAC address patterns (some manufacturers have known prefixes)
    final macPrefix = address.substring(0, 8).toUpperCase();
    switch (macPrefix) {
      case '00:1D:A5':
        return 'ELM327 Device';
      case '00:0D:18':
        return 'Vgate Device';
      case '20:15:03':
      case '20:16:04':
        return 'OBD Scanner';
      default:
        // Use last 4 chars of MAC for identification
        final macParts = address.split(':');
        final shortId =
            macParts.length >= 2
                ? '${macParts[macParts.length - 2]}${macParts[macParts.length - 1]}'
                : macParts.last;
        return 'OBD Device ($shortId)';
    }
  }

  /// Get a scan result for a specific device to access advertisement data
  ScanResult? getScanResult(BluetoothDevice device) {
    try {
      return _discoveredDevices.firstWhere(
        (result) => result.device.remoteId == device.remoteId,
      );
    } catch (e) {
      return null;
    }
  }

  Future<List<BluetoothDevice>> getBondedDevices() async {
    try {
      if (!await isBluetoothOn()) {
        return [];
      }

      final bondedDevices = await FlutterBluePlus.bondedDevices;
      return bondedDevices
          .where((device) => _isLikelyOBDDeviceSimple(device))
          .toList();
    } catch (e) {
      debugPrint('Error getting bonded devices: $e');
      return [];
    }
  }

  bool _isLikelyOBDDeviceSimple(BluetoothDevice device) {
    final deviceName = device.platformName.toLowerCase();

    // Common OBD-II device name patterns
    final obdPatterns = [
      'elm327',
      'obd',
      'obdii',
      'obd-ii',
      'obd2',
      'vgate',
      'icar',
      'torque',
      'scan',
      'diag',
      'automotive',
      'car',
      'vehicle',
      'ecu',
    ];

    // Check device name
    for (String pattern in obdPatterns) {
      if (deviceName.contains(pattern)) {
        return true;
      }
    }

    // Include devices with unknown names (many OBD adapters don't advertise names)
    if (deviceName.isEmpty) {
      return true;
    }

    return false;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(timeout: const Duration(seconds: 15));
    } catch (e) {
      debugPrint('Error connecting to device: $e');
      rethrow;
    }
  }

  Future<void> disconnectDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
    } catch (e) {
      debugPrint('Error disconnecting device: $e');
      rethrow;
    }
  }

  void dispose() {
    _devicesController?.close();
    _devicesController = null;
    _devicesStream = null;
  }
}
