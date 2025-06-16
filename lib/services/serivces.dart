// common_bluetooth_service.dart
import 'dart:developer';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BluetoothFuelService {
  Future<String?> connectAndRead();
}

class OBDService extends BluetoothFuelService {
  Future<double> readFuelLevel() async {
    String? response = await connectAndRead();
    if (response != null) {
      return double.tryParse(response.replaceAll('%', '')) ?? 0.0;
    }
    return 0.0;
  }

  @override
  Future<String?> connectAndRead() async {
    try {
      // Check if Bluetooth is available and enabled
      if (!await FlutterBluePlus.isSupported) {
        return null;
      }

      BluetoothDevice? targetDevice;

      // Start scan with modern syntax
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 5),
        androidUsesFineLocation: true,
      );

      // Listen to scan results
      var subscription = FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (result.device.platformName.contains("OBD")) {
            targetDevice = result.device;
            break;
          }
        }
      });

      // Wait for scan to complete
      await Future.delayed(const Duration(seconds: 5));
      await FlutterBluePlus.stopScan();
      subscription.cancel();

      if (targetDevice == null) return null;

      // Connect with updated parameters
      await targetDevice?.connect(
        timeout: const Duration(seconds: 10),
        autoConnect:
            false, // Changed to false as autoConnect behavior has changed
      );

      List<BluetoothService> services = await targetDevice!.discoverServices();

      for (BluetoothService service in services) {
        for (BluetoothCharacteristic c in service.characteristics) {
          if (c.properties.read) {
            List<int> response = await c.read();
            return String.fromCharCodes(response);
          }
        }
      }
      return null;
    } catch (e) {
      log('Error in OBDService: $e');
      return null;
    } finally {
      await FlutterBluePlus.stopScan();
    }
  }
}

class ESP32Service extends BluetoothFuelService {
  Future<double> readFuelLiters() async {
    String? response = await connectAndRead();
    if (response != null) {
      return double.tryParse(response.replaceAll('L', '')) ?? 0.0;
    }
    return 0.0;
  }

  @override
  Future<String?> connectAndRead() async {
    try {
      if (!await FlutterBluePlus.isSupported) {
        return null;
      }

      BluetoothDevice? targetDevice;

      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 5),
        androidUsesFineLocation: true,
      );

      var subscription = FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (result.device.platformName.contains("ESP32")) {
            targetDevice = result.device;
            break;
          }
        }
      });

      await Future.delayed(const Duration(seconds: 5));
      await FlutterBluePlus.stopScan();
      subscription.cancel();

      if (targetDevice == null) return null;

      await targetDevice?.connect(
        timeout: const Duration(seconds: 10),
        autoConnect: false,
      );

      List<BluetoothService> services = await targetDevice!.discoverServices();

      for (BluetoothService service in services) {
        for (BluetoothCharacteristic c in service.characteristics) {
          if (c.properties.read) {
            List<int> response = await c.read();
            return String.fromCharCodes(response);
          }
        }
      }
      return null;
    } catch (e) {
      log('Error in ESP32Service: $e');
      return null;
    } finally {
      await FlutterBluePlus.stopScan();
    }
  }
}

class J1939Service extends BluetoothFuelService {
  Future<double> readFuelPercentage() async {
    String? response = await connectAndRead();
    if (response != null) {
      return double.tryParse(response.replaceAll('%', '')) ?? 0.0;
    }
    return 0.0;
  }

  @override
  Future<String?> connectAndRead() async {
    try {
      if (!await FlutterBluePlus.isSupported) {
        return null;
      }

      BluetoothDevice? targetDevice;

      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 5),
        androidUsesFineLocation: true,
      );

      var subscription = FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (result.device.platformName.contains("J1939")) {
            targetDevice = result.device;
            break;
          }
        }
      });

      await Future.delayed(const Duration(seconds: 5));
      await FlutterBluePlus.stopScan();
      subscription.cancel();

      if (targetDevice == null) return null;

      await targetDevice?.connect(
        timeout: const Duration(seconds: 10),
        autoConnect: false,
      );

      List<BluetoothService> services = await targetDevice!.discoverServices();

      for (BluetoothService service in services) {
        for (BluetoothCharacteristic c in service.characteristics) {
          if (c.properties.read) {
            List<int> response = await c.read();
            return String.fromCharCodes(response);
          }
        }
      }
      return null;
    } catch (e) {
      log('Error in J1939Service: $e');
      return null;
    } finally {
      await FlutterBluePlus.stopScan();
    }
  }
}
