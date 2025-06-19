import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasources/local/hive_boxes.dart';
import '../data/models/fuel_entry.dart';
import '../data/models/vehicle_data.dart';
import 'services/permission_service.dart';

class DependencyInjection {
  static late SharedPreferences _sharedPreferences;
  static late PermissionService _permissionService;

  static SharedPreferences get sharedPreferences => _sharedPreferences;
  static PermissionService get permissionService => _permissionService;

  static Future<void> initialize() async {
    // Initialize SharedPreferences
    _sharedPreferences = await SharedPreferences.getInstance();

    // Initialize Permission Service
    _permissionService = PermissionService();

    // Register Hive adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(FuelEntryAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(VehicleDataAdapter());
    }

    // Open Hive boxes
    await HiveBoxes.initialize();
  }
}
