import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../providers/vehicle_data_provider.dart';

class DeviceScanList extends ConsumerStatefulWidget {
  final bool isScanning;
  final bool isDemoMode;

  const DeviceScanList({
    super.key,
    required this.isScanning,
    required this.isDemoMode,
  });

  @override
  ConsumerState<DeviceScanList> createState() => _DeviceScanListState();
}

class _DeviceScanListState extends ConsumerState<DeviceScanList> {
  final List<DeviceInfo> _devices = [];

  @override
  void initState() {
    super.initState();
    if (widget.isDemoMode) {
      _addDemoDevices();
    }
  }

  @override
  void didUpdateWidget(DeviceScanList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDemoMode && !oldWidget.isDemoMode) {
      _addDemoDevices();
    } else if (!widget.isDemoMode && oldWidget.isDemoMode) {
      _devices.clear();
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
        ),
        DeviceInfo(
          name: 'OBDII WiFi Scanner',
          address: '192.168.0.10',
          type: DeviceType.wifi,
          rssi: -45,
          isConnected: false,
        ),
        DeviceInfo(
          name: 'Vgate iCar Pro',
          address: '00:1D:A5:68:98:8C',
          type: DeviceType.bluetooth,
          rssi: -72,
          isConnected: true,
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
            Icon(
              Icons.bluetooth_disabled,
              size: 64,
              color: Theme.of(context).disabledColor,
            ),
            const SizedBox(height: 16),
            Text(
              'No devices found',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Theme.of(context).disabledColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap "Scan for Devices" to search',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).disabledColor,
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
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  device.isConnected
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.primary.withValues(alpha: 0.1),
              child: Icon(
                device.type == DeviceType.bluetooth
                    ? Icons.bluetooth
                    : Icons.wifi,
                color:
                    device.isConnected ? AppColors.success : AppColors.primary,
                size: 20,
              ),
            ),
            title: Text(
              device.name,
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.address,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 2),
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing:
                device.isConnected
                    ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Connected',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    : TextButton(
                      onPressed: () => _connectToDevice(device),
                      child: const Text('Connect'),
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

  void _connectToDevice(DeviceInfo device) {
    // Connect using the provider
    ref
        .read(connectionStateProvider.notifier)
        .connect(device.address, device.name);

    setState(() {
      // Disconnect all other devices
      for (var d in _devices) {
        d.isConnected = false;
      }
      // Connect to selected device
      device.isConnected = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connecting to ${device.name}...'),
        backgroundColor: AppColors.info,
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

  DeviceInfo({
    required this.name,
    required this.address,
    required this.type,
    required this.rssi,
    required this.isConnected,
  });
}
