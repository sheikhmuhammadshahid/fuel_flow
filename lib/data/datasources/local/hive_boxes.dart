import 'package:hive/hive.dart';

import '../../models/fuel_entry.dart';
import '../../models/vehicle_data.dart';

class HiveBoxes {
  static const String fuelEntriesBox = 'fuel_entries';
  static const String vehicleDataBox = 'vehicle_data';
  static const String settingsBox = 'settings';

  static Box<FuelEntry>? _fuelEntriesBox;
  static Box<VehicleData>? _vehicleDataBox;
  static Box? _settingsBox;

  static Future<void> initialize() async {
    try {
      _fuelEntriesBox = await Hive.openBox<FuelEntry>(fuelEntriesBox);
      _vehicleDataBox = await Hive.openBox<VehicleData>(vehicleDataBox);
      _settingsBox = await Hive.openBox(settingsBox);
    } catch (e) {
      // Handle initialization errors
      // TODO: Replace with proper logging in production
      assert(() {
        print('Error initializing Hive boxes: $e');
        return true;
      }());
    }
  }

  static Box<FuelEntry> get fuelEntries {
    if (_fuelEntriesBox == null || !_fuelEntriesBox!.isOpen) {
      throw Exception('FuelEntries box is not initialized');
    }
    return _fuelEntriesBox!;
  }

  static Box<VehicleData> get vehicleData {
    if (_vehicleDataBox == null || !_vehicleDataBox!.isOpen) {
      throw Exception('VehicleData box is not initialized');
    }
    return _vehicleDataBox!;
  }

  static Box get settings {
    if (_settingsBox == null || !_settingsBox!.isOpen) {
      throw Exception('Settings box is not initialized');
    }
    return _settingsBox!;
  }

  static Future<void> closeAll() async {
    await _fuelEntriesBox?.close();
    await _vehicleDataBox?.close();
    await _settingsBox?.close();
  }
}
