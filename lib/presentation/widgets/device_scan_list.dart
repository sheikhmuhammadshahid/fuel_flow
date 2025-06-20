import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../../core/services/bluetooth_service.dart' as bt_service;
import '../providers/vehicle_data_provider.dart';

class DeviceScanList extends ConsumerStatefulWidget {
  final bool isScanning;
  final bool isDemoMode;
  final Function(DeviceInfo)? onDeviceFound;
  final List<Map<String, dynamic>>? externalDevices;

  const DeviceScanList({
    super.key,
    required this.isScanning,
    required this.isDemoMode,
    this.onDeviceFound,
    this.externalDevices,
  });

  @override
  ConsumerState<DeviceScanList> createState() => _DeviceScanListState();
}

class _DeviceScanListState extends ConsumerState<DeviceScanList> {
  final List<DeviceInfo> _devices = [];
  final bt_service.FuelFlowBluetoothService _bluetoothService =
      bt_service.FuelFlowBluetoothService();

  @override
  void initState() {
    super.initState();
    if (widget.isDemoMode) {
      _addDemoDevices();
    } else {
      _addExternalDevices();
    }
  }

  @override
  void didUpdateWidget(DeviceScanList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDemoMode && !oldWidget.isDemoMode) {
      _addDemoDevices();
    } else if (!widget.isDemoMode && oldWidget.isDemoMode) {
      _devices.clear();
      _addExternalDevices();
    } else if (widget.externalDevices != oldWidget.externalDevices) {
      _addExternalDevices();
    }
  }

  void _addExternalDevices() {
    if (widget.externalDevices != null && !widget.isDemoMode) {
      setState(() {
        _devices.clear();
        for (var deviceData in widget.externalDevices!) {
          _devices.add(
            DeviceInfo(
              name: deviceData['name'] ?? 'Unknown Device',
              address: deviceData['address'] ?? '00:00:00:00:00:00',
              type:
                  deviceData['type'] == 'wifi'
                      ? DeviceType.wifi
                      : DeviceType.bluetooth,
              rssi: deviceData['rssi'] ?? -80,
              isConnected: false,
              lastSeen: DateTime.now(),
              bluetoothDevice:
                  deviceData['deviceObject']
                      as BluetoothDevice?, // Include the real device object
            ),
          );
        }
      });
    }
  }

  void _addDemoDevices() {
    setState(() {
      _devices.clear();
      _devices.addAll([
        DeviceInfo(
          name: 'ELM327 OBD-II',
          address: '00:1D:A5:68:98:8B',
          type: DeviceType.bluetooth,
          rssi: -65,
          isConnected: false,
          lastSeen: DateTime.now(),
        ),
        DeviceInfo(
          name: 'OBDII WiFi Scanner',
          address: '192.168.0.10',
          type: DeviceType.wifi,
          rssi: -45,
          isConnected: false,
          lastSeen: DateTime.now().subtract(const Duration(minutes: 2)),
        ),
        DeviceInfo(
          name: 'Vgate iCar Pro',
          address: '00:1D:A5:68:98:8C',
          type: DeviceType.bluetooth,
          rssi: -72,
          isConnected: true,
          lastSeen: DateTime.now(),
        ),
        DeviceInfo(
          name: 'Torque Pro BT',
          address: '00:1D:A5:68:98:8D',
          type: DeviceType.bluetooth,
          rssi: -58,
          isConnected: false,
          lastSeen: DateTime.now().subtract(const Duration(seconds: 30)),
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_devices.isEmpty && !widget.isScanning) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bluetooth_disabled,
                size: 48,
                color: AppColors.grey500,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No devices found',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.grey700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.isDemoMode
                  ? 'Enable demo mode and scan to see sample devices'
                  : 'Make sure your OBD-II device is discoverable and try scanning again',
              style: GoogleFonts.inter(fontSize: 14, color: AppColors.grey600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Trigger a new scan by calling the parent's scan function
                  // This is a bit of a hack, but works for the current implementation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Please use the "Scan for Devices" button above',
                      ),
                      backgroundColor: AppColors.info,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: Text(
                  'Scan Again',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _devices.length + (widget.isScanning ? 1 : 0),
      itemBuilder: (context, index) {
        if (widget.isScanning && index == _devices.length) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              title: Text(
                'Scanning for devices...',
                style: GoogleFonts.inter(fontStyle: FontStyle.italic),
              ),
            ),
          );
        }

        final device = _devices[index];
        final isStale =
            DateTime.now().difference(device.lastSeen).inMinutes > 5;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: device.isConnected ? 4 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side:
                device.isConnected
                    ? BorderSide(color: AppColors.success, width: 2)
                    : BorderSide.none,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    device.isConnected
                        ? AppColors.success.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Icon(
                    device.type == DeviceType.bluetooth
                        ? Icons.bluetooth
                        : Icons.wifi,
                    color:
                        device.isConnected
                            ? AppColors.success
                            : AppColors.primary,
                    size: 20,
                  ),
                  if (device.isConnected)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            title: Text(
              device.name,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: isStale ? AppColors.grey500 : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.address,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.grey600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.signal_cellular_alt,
                      size: 12,
                      color: _getSignalColor(device.rssi),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${device.rssi} dBm',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: _getSignalColor(device.rssi),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time, size: 12, color: AppColors.grey500),
                    const SizedBox(width: 4),
                    Text(
                      _formatLastSeen(device.lastSeen),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing:
                device.isConnected
                    ? GestureDetector(
                      onTap: () => _disconnectDevice(device),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.success,
                              AppColors.success.withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Connected',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.close, size: 12, color: Colors.white),
                          ],
                        ),
                      ),
                    )
                    : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed:
                            isStale ? null : () => _connectToDevice(device),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Connect',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
          ),
        );
      },
    );
  }

  Color _getSignalColor(int rssi) {
    if (rssi >= -50) return AppColors.success;
    if (rssi >= -70) return AppColors.warning;
    return AppColors.error;
  }

  String _formatLastSeen(DateTime lastSeen) {
    final difference = DateTime.now().difference(lastSeen);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _connectToDevice(DeviceInfo device) async {
    // Show connecting state
    setState(() {
      // Disconnect all other devices
      for (var d in _devices) {
        d.isConnected = false;
      }
    });

    // Show connecting dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Connecting to ${device.name}',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'This may take a few seconds...',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.grey600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
    );

    try {
      // Check if this device has a real BluetoothDevice object
      if (device.bluetoothDevice != null) {
        // Connect to real Bluetooth device
        await _bluetoothService.connectToDevice(device.bluetoothDevice!);
      } else {
        // Fallback to provider-based connection for demo devices
        await ref
            .read(connectionStateProvider.notifier)
            .connect(device.address, device.name);
      }

      // Simulate connection time for demo
      if (device.bluetoothDevice == null) {
        await Future.delayed(const Duration(seconds: 2));
      }

      if (mounted) {
        Navigator.of(context).pop(); // Close connecting dialog

        setState(() {
          device.isConnected = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Successfully connected to ${device.name}'),
                ),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close connecting dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text('Failed to connect: ${e.toString()}')),
              ],
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  void _disconnectDevice(DeviceInfo device) async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Disconnect Device',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            content: Text(
              'Are you sure you want to disconnect from ${device.name}?',
              style: GoogleFonts.inter(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(color: AppColors.grey600),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.error,
                      AppColors.error.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();

                    try {
                      // Check if this device has a real BluetoothDevice object
                      if (device.bluetoothDevice != null) {
                        // Disconnect from real Bluetooth device
                        await _bluetoothService.disconnectDevice(
                          device.bluetoothDevice!,
                        );
                      } else {
                        // Fallback to provider-based disconnection for demo devices
                        await ref
                            .read(connectionStateProvider.notifier)
                            .disconnect();
                      }

                      setState(() {
                        device.isConnected = false;
                      });

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Disconnected from ${device.name}',
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: AppColors.info,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Disconnect failed: ${e.toString()}'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Disconnect',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

enum DeviceType { bluetooth, wifi }

class DeviceInfo {
  final String name;
  final String address;
  final DeviceType type;
  final int rssi;
  bool isConnected;
  final DateTime lastSeen;
  final BluetoothDevice? bluetoothDevice; // For real Bluetooth devices

  DeviceInfo({
    required this.name,
    required this.address,
    required this.type,
    required this.rssi,
    required this.isConnected,
    required this.lastSeen,
    this.bluetoothDevice,
  });
}
