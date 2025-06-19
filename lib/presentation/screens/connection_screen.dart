import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../../core/dependency_injection.dart';
import '../widgets/device_scan_list.dart';
import '../widgets/permission_check_widget.dart';

class ConnectionScreen extends ConsumerStatefulWidget {
  const ConnectionScreen({super.key});

  @override
  ConsumerState<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends ConsumerState<ConnectionScreen> {
  bool _isScanning = false;
  bool _isDemoMode = false;

  @override
  Widget build(BuildContext context) {
    return PermissionCheckWidget(
      requiredPermissions: const ['bluetooth', 'location'],
      title: 'Bluetooth & Location Required',
      description:
          'Device scanning requires Bluetooth and Location permissions to discover nearby OBD-II devices.',
      child: _buildConnectionScreen(context),
    );
  }

  Widget _buildConnectionScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device Connection',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'demo') {
                setState(() {
                  _isDemoMode = !_isDemoMode;
                });
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'demo',
                    child: Row(
                      children: [
                        Icon(
                          _isDemoMode
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        const Text('Demo Mode'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Demo Mode Banner
            if (_isDemoMode)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warning, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Demo mode is active. Showing simulated data.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Connection Instructions
            Text(
              'Connect to OBD-II Device',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Text(
              'Make sure your OBD-II adapter is plugged into your vehicle and discoverable.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              ),
            ),

            const SizedBox(height: 24),

            // Scan Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isScanning ? null : _startScan,
                icon:
                    _isScanning
                        ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        )
                        : const Icon(Icons.search),
                label: Text(_isScanning ? 'Scanning...' : 'Scan for Devices'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Device List
            Text(
              'Available Devices',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: DeviceScanList(
                isScanning: _isScanning,
                isDemoMode: _isDemoMode,
              ),
            ),

            // Connection Tips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppColors.info,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Connection Tips',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: AppColors.info,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Make sure your vehicle is turned on\n'
                    '• Check that the OBD-II adapter is securely connected\n'
                    '• For Bluetooth devices, ensure they are in pairing mode\n'
                    '• Common device names: ELM327, OBD2, OBDII',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.info,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startScan() async {
    // Check and request permissions before scanning
    final permissionService = DependencyInjection.permissionService;

    // Request Bluetooth permissions
    final hasBluetoothPermissions =
        await permissionService.requestBluetoothPermissions();

    if (!hasBluetoothPermissions) {
      if (mounted) {
        await permissionService.showPermissionDeniedDialog(context);
      }
      return;
    }

    setState(() {
      _isScanning = true;
    });

    // Simulate scanning process
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    });
  }
}
