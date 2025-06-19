import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  /// Check and request all necessary permissions for the app
  Future<bool> requestAllPermissions() async {
    final permissions = [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
      Permission.locationWhenInUse,
    ];

    // Check current status
    Map<Permission, PermissionStatus> statuses = await permissions.request();

    // Check if all required permissions are granted
    bool allGranted = true;
    for (Permission permission in permissions) {
      final status = statuses[permission];
      if (status != PermissionStatus.granted) {
        allGranted = false;
        debugPrint('Permission ${permission.toString()} not granted: $status');
      }
    }

    return allGranted;
  }

  /// Request Bluetooth permissions specifically
  Future<bool> requestBluetoothPermissions() async {
    final permissions = [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location, // Required for Bluetooth scanning
    ];

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    return _checkPermissionsGranted(statuses, permissions);
  }

  /// Request Location permissions
  Future<bool> requestLocationPermissions() async {
    final permissions = [Permission.location, Permission.locationWhenInUse];

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    return _checkPermissionsGranted(statuses, permissions);
  }

  /// Request WiFi permissions
  Future<bool> requestWiFiPermissions() async {
    final permissions = [
      Permission.location, // Required for WiFi scanning
    ];

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    return _checkPermissionsGranted(statuses, permissions);
  }

  /// Check if Bluetooth permissions are granted
  Future<bool> hasBluetoothPermissions() async {
    final bluetoothScan = await Permission.bluetoothScan.status;
    final bluetoothConnect = await Permission.bluetoothConnect.status;
    final location = await Permission.location.status;

    return bluetoothScan.isGranted &&
        bluetoothConnect.isGranted &&
        location.isGranted;
  }

  /// Check if Location permissions are granted
  Future<bool> hasLocationPermissions() async {
    final location = await Permission.location.status;
    return location.isGranted;
  }

  /// Show permission dialog to user
  Future<bool> showPermissionDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Permissions Required'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This app requires the following permissions to function properly:',
                  ),
                  SizedBox(height: 12),
                  Text('• Bluetooth - To connect to OBD-II devices'),
                  Text(
                    '• Location - Required for Bluetooth scanning and GPS tracking',
                  ),
                  Text('• WiFi - To connect to WiFi-enabled OBD devices'),
                  SizedBox(height: 12),
                  Text('Please grant these permissions to continue.'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Grant Permissions'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Open app settings for manual permission grant
  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Show permission denied dialog
  Future<void> showPermissionDeniedDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Denied'),
          content: const Text(
            'Some permissions were denied. The app may not function properly. '
            'Please go to Settings and grant the required permissions manually.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  /// Helper method to check if permissions are granted
  bool _checkPermissionsGranted(
    Map<Permission, PermissionStatus> statuses,
    List<Permission> permissions,
  ) {
    for (Permission permission in permissions) {
      final status = statuses[permission];
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
