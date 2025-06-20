import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../../core/dependency_injection.dart';
import '../../core/services/bluetooth_service.dart' as bt_service;
import '../../data/models/user_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/device_scan_list.dart';
import '../widgets/permission_check_widget.dart';
import 'login_screen.dart';
import 'pricing_screen.dart';

class ConnectionScreen extends ConsumerStatefulWidget {
  const ConnectionScreen({super.key});

  @override
  ConsumerState<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends ConsumerState<ConnectionScreen> {
  bool _isScanning = false;
  bool _isDemoMode = false;
  List<Map<String, dynamic>> _foundDevices = [];
  final bt_service.FuelFlowBluetoothService _bluetoothService =
      bt_service.FuelFlowBluetoothService();

  @override
  Widget build(BuildContext context) {
    final currentUserAsync = ref.watch(currentUserProvider);

    return currentUserAsync.when(
      data: (user) {
        if (user == null) {
          // User not authenticated, show login requirement
          return _buildAuthRequiredScreen(context);
        }

        // Check subscription status
        return ref
            .watch(currentUserModelProvider)
            .when(
              data: (userModel) {
                if (userModel != null && !_canConnectToDevice(userModel)) {
                  // User's trial expired or no subscription
                  return _buildSubscriptionRequiredScreen(context, userModel);
                }

                // User is authenticated and has valid subscription/trial
                return PermissionCheckWidget(
                  requiredPermissions: const ['bluetooth', 'location'],
                  title: 'Bluetooth & Location Required',
                  description:
                      'Device scanning requires Bluetooth and Location permissions to discover nearby OBD-II devices.',
                  child: _buildConnectionScreen(context),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => _buildAuthRequiredScreen(context),
            );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _buildAuthRequiredScreen(context),
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
                externalDevices: _foundDevices,
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
                mainAxisSize: MainAxisSize.min,
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

  // Check if user can connect to device (has valid subscription or trial)
  bool _canConnectToDevice(UserModel userModel) {
    final now = DateTime.now();

    // Check if user has active subscription
    final subscription = userModel.subscription;

    // If it's not a free subscription, check if it's still valid
    bool hasActiveSubscription = subscription.when(
      free: () => false,
      weekly: (startDate, endDate, _) => now.isBefore(endDate),
      monthly: (startDate, endDate, _) => now.isBefore(endDate),
      yearly: (startDate, endDate, _) => now.isBefore(endDate),
    );

    if (hasActiveSubscription) {
      return true;
    }

    // Check if user is still in free trial period
    if (userModel.freeTrialEndDate != null) {
      return now.isBefore(userModel.freeTrialEndDate!);
    }

    return false;
  }

  Widget _buildAuthRequiredScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Authentication Required',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary.withOpacity(0.1), AppColors.background],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Login Required',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'You need to be logged in to connect to OBD-II devices. This helps us provide you with a personalized experience and track your usage.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.grey600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: Text(
                      'Login / Sign Up',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionRequiredScreen(
    BuildContext context,
    UserModel userModel,
  ) {
    final daysRemaining =
        userModel.freeTrialEndDate != null
            ? userModel.freeTrialEndDate!.difference(DateTime.now()).inDays
            : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription Required',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.schedule, size: 80, color: AppColors.warning),
            const SizedBox(height: 24),
            Text(
              daysRemaining > 0
                  ? 'Free Trial Ending Soon'
                  : 'Free Trial Expired',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              daysRemaining > 0
                  ? 'Your free trial ends in $daysRemaining day${daysRemaining == 1 ? '' : 's'}. Subscribe now to continue using device connection features.'
                  : 'Your free trial has expired. Subscribe to continue connecting to OBD-II devices and accessing premium features.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PricingScreen()),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('View Pricing Plans'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (daysRemaining > 0)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Continue with Trial ($daysRemaining day${daysRemaining == 1 ? '' : 's'} left)',
                  style: GoogleFonts.inter(color: AppColors.primary),
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
      // Clear previous results when starting a new scan
      if (!_isDemoMode) {
        _foundDevices = [];
      }
    });

    try {
      // Clear any previous error messages
      ScaffoldMessenger.of(context).clearSnackBars();

      // Show scanning started message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Scanning for OBD-II devices...'),
            ],
          ),
          backgroundColor: AppColors.info,
          duration: const Duration(seconds: 2),
        ),
      );

      if (_isDemoMode) {
        // In demo mode, simulate scanning with predefined devices
        await _simulateDemoScan();
      } else {
        // Real scanning implementation
        await _performRealScan();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Scan failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  Future<void> _simulateDemoScan() async {
    // Simulate scanning time
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Clear any external devices since demo mode handles its own devices
      setState(() {
        _foundDevices = [];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Demo scan completed - 4 devices found'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Future<void> _performRealScan() async {
    try {
      // Check if Bluetooth is available and enabled
      if (!await _bluetoothService.isBluetoothOn()) {
        throw Exception('Bluetooth is not enabled');
      }

      // Perform the actual scan using BluetoothService
      final List<BluetoothDevice> foundBluetoothDevices =
          await _bluetoothService.scanForDevices(
            timeout: const Duration(seconds: 10),
          );

      if (mounted) {
        // Convert BluetoothDevice objects to our Map format
        final List<Map<String, dynamic>> foundDevices =
            foundBluetoothDevices.map((device) {
              // Get scan result for advertisement data
              final scanResult = _bluetoothService.getScanResult(device);
              final advertisementData = scanResult?.advertisementData;

              // Use improved device naming
              final deviceName = _bluetoothService.getDeviceName(
                device,
                adData: advertisementData,
              );

              return {
                'name': deviceName,
                'address': device.remoteId.toString(),
                'type': 'bluetooth',
                'rssi': scanResult?.rssi ?? -60, // Use actual RSSI if available
                'deviceObject':
                    device, // Store the actual device object for later use
              };
            }).toList();

        // Also check for bonded devices
        final List<BluetoothDevice> bondedDevices =
            await _bluetoothService.getBondedDevices();
        for (var device in bondedDevices) {
          // Avoid duplicates
          if (!foundDevices.any(
            (d) => d['address'] == device.remoteId.toString(),
          )) {
            // Use improved device naming for bonded devices too
            final deviceName = _bluetoothService.getDeviceName(device);

            foundDevices.add({
              'name': deviceName,
              'address': device.remoteId.toString(),
              'type': 'bluetooth',
              'rssi': -50, // Bonded devices typically have better signal
              'deviceObject': device,
            });
          }
        }

        // Update the state with found devices
        setState(() {
          _foundDevices = foundDevices;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Scan completed - ${foundDevices.length} devices found',
            ),
            backgroundColor:
                foundDevices.isNotEmpty ? AppColors.success : AppColors.warning,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // Fallback to simulated scan if real scan fails
        await _performFallbackScan();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Real scan failed: ${e.toString()}, showing simulated devices',
            ),
            backgroundColor: AppColors.warning,
          ),
        );
      }
    }
  }

  Future<void> _performFallbackScan() async {
    // Fallback to simulated scanning with some random devices
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      // Simulate finding some real devices
      final List<Map<String, dynamic>> foundDevices = [
        {
          'name': 'ELM327-${DateTime.now().millisecond}',
          'address': _generateRandomMacAddress(),
          'type': 'bluetooth',
          'rssi': -65 + (DateTime.now().millisecond % 20),
        },
        if (DateTime.now().second % 2 == 0)
          {
            'name': 'OBD-II Scanner',
            'address': _generateRandomMacAddress(),
            'type': 'bluetooth',
            'rssi': -75 + (DateTime.now().millisecond % 15),
          },
        if (DateTime.now().second % 3 == 0)
          {
            'name': 'Vgate iCar',
            'address': _generateRandomMacAddress(),
            'type': 'bluetooth',
            'rssi': -55 + (DateTime.now().millisecond % 25),
          },
      ];

      // Update the state with found devices
      setState(() {
        _foundDevices = foundDevices;
      });
    }
  }

  String _generateRandomMacAddress() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return '${(random % 256).toRadixString(16).padLeft(2, '0')}:'
        '${((random >> 8) % 256).toRadixString(16).padLeft(2, '0')}:'
        '${((random >> 16) % 256).toRadixString(16).padLeft(2, '0')}:'
        '${((random >> 24) % 256).toRadixString(16).padLeft(2, '0')}:'
        '${((random >> 32) % 256).toRadixString(16).padLeft(2, '0')}:'
        '${((random >> 40) % 256).toRadixString(16).padLeft(2, '0')}';
  }
}
