import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

/// Enhanced device info to store more details
class DeviceInfo {
  final BluetoothDevice device;
  final String? advertisementName;
  final int? rssi;

  DeviceInfo({required this.device, this.advertisementName, this.rssi});

  String get displayName {
    if (device.platformName.isNotEmpty) {
      return device.platformName;
    } else if (advertisementName != null && advertisementName!.isNotEmpty) {
      return advertisementName!;
    } else if (device.localName.isNotEmpty) {
      return device.localName;
    } else {
      return 'Unknown Device (${device.remoteId.str.substring(0, 8)}...)';
    }
  }
}

/// Represents OBD-II data retrieved from the vehicle.
class OBDData {
  final double rpm;
  final double speed;
  final double fuelLevel;
  final double coolantTemp;
  final List<String> dtcCodes;

  OBDData({
    required this.rpm,
    required this.speed,
    required this.fuelLevel,
    required this.coolantTemp,
    required this.dtcCodes,
  });
}

/// Service class to handle OBD-II communication over Bluetooth.
class OBDFullService {
  BluetoothDevice? targetDevice;
  BluetoothCharacteristic? targetCharacteristic;
  Map<String, DeviceInfo> deviceInfoMap = {}; // Store enhanced device info
  Future<void> connectToSelectedDevice(BluetoothDevice device) async {
    try {
      // Connect to the selected device
      await device.connect(
        timeout: const Duration(seconds: 15),
        autoConnect: false,
      );

      // Discover services and characteristics
      final services = await device.discoverServices();
      for (final service in services) {
        for (final characteristic in service.characteristics) {
          if (characteristic.properties.write &&
              characteristic.properties.read) {
            targetCharacteristic = characteristic;
            targetDevice = device;
            return;
          }
        }
      }
      throw Exception("No compatible characteristic found on device");
    } catch (e) {
      await device.disconnect();
      rethrow;
    }
  }

  Future<bool> checkBluetoothPermissions() async {
    if (await Permission.bluetoothScan.isDenied ||
        await Permission.bluetoothConnect.isDenied ||
        await Permission.bluetoothAdvertise.isDenied ||
        await Permission.locationWhenInUse.isDenied) {
      await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.bluetoothAdvertise,
        Permission.locationWhenInUse,
      ].request();
      if (await Permission.bluetoothScan.isDenied ||
          await Permission.bluetoothConnect.isDenied ||
          await Permission.bluetoothAdvertise.isDenied ||
          await Permission.locationWhenInUse.isDenied) {
        return false;
      }
    }

    if (await Permission.bluetoothScan.isPermanentlyDenied ||
        await Permission.bluetoothConnect.isPermanentlyDenied ||
        await Permission.bluetoothAdvertise.isPermanentlyDenied ||
        await Permission.locationWhenInUse.isPermanentlyDenied) {
      // You can guide the user to settings
      openAppSettings();
      return false;
    }
    return true;
  }

  /// Connects to an OBD-II device via Bluetooth.
  Future<List<BluetoothDevice>> scanForBluetoothDevices() async {
    if (!(await checkBluetoothPermissions())) {
      return [];
    }

    List<BluetoothDevice> discoveredDevices = [];
    Map<String, DeviceInfo> deviceInfoMap = {}; // To store enhanced device info
    StreamSubscription<List<ScanResult>>? scanSubscription;

    try {
      // Check Bluetooth availability and state
      if (!await FlutterBluePlus.isSupported) {
        throw Exception("Bluetooth is not available on this device");
      }

      final adapterState = await FlutterBluePlus.adapterState.first;
      if (adapterState != BluetoothAdapterState.on) {
        throw Exception("Please enable Bluetooth to continue");
      }

      // Clear any previous results
      discoveredDevices.clear();
      deviceInfoMap.clear();

      // Create a completer to handle the scan completion
      final completer = Completer<List<BluetoothDevice>>();

      // Start scanning for all nearby devices
      await FlutterBluePlus.startScan(
        timeout: Duration(seconds: 15),
        androidUsesFineLocation: true,
        // Scan for both classic and BLE devices
      );

      // Listen to scan results
      scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        for (final scanResult in results) {
          final deviceId = scanResult.device.remoteId.str;

          // Store device info including advertisement data
          deviceInfoMap[deviceId] = DeviceInfo(
            device: scanResult.device,
            advertisementName: scanResult.advertisementData.localName,
            rssi: scanResult.rssi,
          );

          // Only add device if it's not already in the list
          if (!discoveredDevices.any(
            (d) => d.remoteId == scanResult.device.remoteId,
          )) {
            discoveredDevices.add(scanResult.device);
          }
        }
      }, onError: (e) => completer.completeError(e));

      // Complete when scanning is done
      FlutterBluePlus.isScanning.firstWhere((isScanning) => !isScanning).then((
        _,
      ) async {
        if (!completer.isCompleted) {
          // Try to get names for devices that don't have them
          for (final device in discoveredDevices) {
            final deviceId = device.remoteId.str;
            final deviceInfo = deviceInfoMap[deviceId];

            // If device doesn't have a proper name, try a brief connection to get it
            if (deviceInfo != null &&
                deviceInfo.displayName.contains('Unknown Device') &&
                device.platformName.isEmpty &&
                device.localName.isEmpty) {
              try {
                // Very brief connection attempt to get device name
                await device.connect(
                  timeout: const Duration(seconds: 2),
                  autoConnect: false,
                );
                await device.disconnect();

                // Update device info with potentially new name
                deviceInfoMap[deviceId] = DeviceInfo(
                  device: device,
                  advertisementName: deviceInfo.advertisementName,
                  rssi: deviceInfo.rssi,
                );
              } catch (e) {
                // Ignore connection errors, just continue with unknown name
              }
            }
          }

          completer.complete(discoveredDevices);
        }
      });

      return await completer.future;
    } catch (e) {
      rethrow;
    } finally {
      await FlutterBluePlus.stopScan();
      await scanSubscription?.cancel();
    }
  }

  /// Sends an OBD-II command to the device.
  Future<void> sendCommand(String command) async {
    if (targetCharacteristic == null) {
      throw Exception("Not connected to OBD device");
    }
    await targetCharacteristic!.write(
      utf8.encode("$command\r"),
      withoutResponse: true,
      timeout: 5, // Timeout in seconds
    );
    await Future.delayed(const Duration(milliseconds: 200)); // Reduced delay
  }

  /// Reads the response from the OBD-II device.
  Future<String> readResponse() async {
    if (targetCharacteristic == null) {
      throw Exception("Not connected to OBD device");
    }
    final response = await targetCharacteristic!.read(timeout: 5);
    return utf8.decode(response).trim();
  }

  /// Parses a hexadecimal string to a double with an optional scaling factor.
  double parseHexToDouble(String hex, {int factor = 1}) {
    try {
      return int.parse(hex, radix: 16) / factor;
    } catch (e) {
      return 0.0; // Fallback value on parse failure
    }
  }

  /// Retrieves engine RPM (Revolutions Per Minute).
  Future<double> getRPM() async {
    await sendCommand("010C");
    final response = await readResponse();
    final parts = response.split(" ");
    if (parts.length >= 4 && parts[0] == "41" && parts[1] == "0C") {
      final a = int.parse(parts[2], radix: 16);
      final b = int.parse(parts[3], radix: 16);
      return ((a * 256) + b) / 4.0;
    }
    return 0.0;
  }

  /// Retrieves vehicle speed in km/h.
  Future<double> getSpeed() async {
    await sendCommand("010D");
    final response = await readResponse();
    final parts = response.split(" ");
    if (parts.length >= 3 && parts[0] == "41" && parts[1] == "0D") {
      return parseHexToDouble(parts[2]);
    }
    return 0.0;
  }

  /// Retrieves fuel level as a percentage.
  Future<double> getFuelLevel() async {
    await sendCommand("012F");
    final response = await readResponse();
    final parts = response.split(" ");
    if (parts.length >= 3 && parts[0] == "41" && parts[1] == "2F") {
      final a = int.parse(parts[2], radix: 16);
      return (a * 100.0) / 255.0;
    }
    return 0.0;
  }

  /// Retrieves coolant temperature in Celsius.
  Future<double> getCoolantTemperature() async {
    await sendCommand("0105");
    final response = await readResponse();
    final parts = response.split(" ");
    if (parts.length >= 3 && parts[0] == "41" && parts[1] == "05") {
      return parseHexToDouble(parts[2]) - 40;
    }
    return 0.0;
  }

  /// Retrieves Diagnostic Trouble Codes (DTCs).
  Future<List<String>> getDtcCodes() async {
    await sendCommand("03");
    final response = await readResponse();
    final cleaned = response.replaceAll(" ", "").toUpperCase();
    final codes = <String>[];
    if (cleaned.startsWith("43") && cleaned.length > 4) {
      final rawCodes = cleaned.substring(2);
      for (int i = 0; i < rawCodes.length - 3; i += 4) {
        final code = rawCodes.substring(i, i + 4);
        if (code != "0000") codes.add(_formatDtcCode(code));
      }
    }
    return codes;
  }

  /// Formats raw DTC code into standard format (e.g., P0301).
  String _formatDtcCode(String raw) {
    const prefixes = [
      'P0',
      'P1',
      'P2',
      'P3',
      'C0',
      'C1',
      'C2',
      'C3',
      'B0',
      'B1',
      'B2',
      'B3',
      'U0',
      'U1',
      'U2',
      'U3',
    ];
    final firstByte = int.parse(raw.substring(0, 2), radix: 16);
    final index = firstByte >> 4; // Extract prefix index
    return "${prefixes[index]}${raw.substring(2)}";
  }

  /// Clears Diagnostic Trouble Codes (DTCs).
  Future<void> clearDtcCodes() async {
    await sendCommand("04");
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Allow time for clearing
  }

  /// Reads all available OBD-II data in one call.
  Future<OBDData> readAllOBDData() async {
    final rpm = await getRPM();
    final speed = await getSpeed();
    final fuel = await getFuelLevel();
    final temp = await getCoolantTemperature();
    final dtcs = await getDtcCodes();
    return OBDData(
      rpm: rpm,
      speed: speed,
      fuelLevel: fuel,
      coolantTemp: temp,
      dtcCodes: dtcs,
    );
  }

  /// Disconnects from the OBD-II device.
  Future<void> disconnect() async {
    await targetDevice?.disconnect();
    targetDevice = null;
    targetCharacteristic = null;
  }

  /// Gets the display name for a device
  String getDeviceDisplayName(BluetoothDevice device) {
    final deviceId = device.remoteId.str;
    final deviceInfo = deviceInfoMap[deviceId];

    if (deviceInfo != null) {
      return deviceInfo.displayName;
    }

    // Fallback to basic device properties
    if (device.platformName.isNotEmpty) {
      return device.platformName;
    } else if (device.localName.isNotEmpty) {
      return device.localName;
    } else {
      return 'Unknown Device (${device.remoteId.str.substring(0, 8)}...)';
    }
  }

  /// Gets additional device info like RSSI
  DeviceInfo? getDeviceInfo(BluetoothDevice device) {
    return deviceInfoMap[device.remoteId.str];
  }
}
