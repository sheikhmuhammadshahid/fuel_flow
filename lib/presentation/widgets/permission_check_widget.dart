import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../../core/dependency_injection.dart';

class PermissionCheckWidget extends StatefulWidget {
  final Widget child;
  final List<String> requiredPermissions;
  final String title;
  final String description;

  const PermissionCheckWidget({
    super.key,
    required this.child,
    required this.requiredPermissions,
    this.title = 'Permissions Required',
    this.description =
        'This feature requires additional permissions to function properly.',
  });

  @override
  State<PermissionCheckWidget> createState() => _PermissionCheckWidgetState();
}

class _PermissionCheckWidgetState extends State<PermissionCheckWidget> {
  bool _hasPermissions = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final permissionService = DependencyInjection.permissionService;

    // Check specific permissions based on required permissions
    bool hasPermissions = true;

    if (widget.requiredPermissions.contains('bluetooth')) {
      hasPermissions =
          hasPermissions && await permissionService.hasBluetoothPermissions();
    }

    if (widget.requiredPermissions.contains('location')) {
      hasPermissions =
          hasPermissions && await permissionService.hasLocationPermissions();
    }

    if (mounted) {
      setState(() {
        _hasPermissions = hasPermissions;
        _isChecking = false;
      });
    }
  }

  Future<void> _requestPermissions() async {
    final permissionService = DependencyInjection.permissionService;

    // Show permission dialog first
    final shouldRequest = await permissionService.showPermissionDialog(context);
    if (!shouldRequest) return;

    setState(() {
      _isChecking = true;
    });

    bool granted = false;

    if (widget.requiredPermissions.contains('bluetooth')) {
      granted = await permissionService.requestBluetoothPermissions();
    } else if (widget.requiredPermissions.contains('location')) {
      granted = await permissionService.requestLocationPermissions();
    } else {
      granted = await permissionService.requestAllPermissions();
    }

    if (mounted) {
      setState(() {
        _hasPermissions = granted;
        _isChecking = false;
      });

      if (!granted) {
        await permissionService.showPermissionDeniedDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_hasPermissions) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.security, size: 80, color: AppColors.warning),
                const SizedBox(height: 24),
                Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.description,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildPermissionsList(),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _requestPermissions,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Grant Permissions'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widget.child;
  }

  Widget _buildPermissionsList() {
    final permissions = <String, String>{
      'bluetooth': 'Bluetooth - Connect to OBD-II devices',
      'location': 'Location - Required for Bluetooth scanning and GPS tracking',
      'wifi': 'WiFi - Connect to WiFi-enabled devices',
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Required Permissions:',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.info,
            ),
          ),
          const SizedBox(height: 8),
          ...widget.requiredPermissions.map((permission) {
            final description = permissions[permission] ?? permission;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.info,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
