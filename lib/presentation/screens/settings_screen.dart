import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isDarkMode = false;
  bool _autoDetectFuel = true;
  bool _notificationsEnabled = true;
  String _selectedUnit = 'Liters';
  double _tankCapacity = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Settings
            Text(
              'Vehicle Settings',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.local_gas_station,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: const Text('Tank Capacity'),
                    subtitle: Text('${_tankCapacity.toStringAsFixed(1)} L'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showTankCapacityDialog,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary.withValues(
                        alpha: 0.1,
                      ),
                      child: Icon(
                        Icons.straighten,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                    title: const Text('Fuel Unit'),
                    subtitle: Text(_selectedUnit),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showUnitDialog,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor: AppColors.accent.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.auto_fix_high,
                        color: AppColors.accent,
                        size: 20,
                      ),
                    ),
                    title: const Text('Auto Detect Fuel Refills'),
                    subtitle: const Text(
                      'Automatically log fuel when detected',
                    ),
                    value: _autoDetectFuel,
                    onChanged: (value) {
                      setState(() {
                        _autoDetectFuel = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // App Settings
            Text(
              'App Settings',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor: AppColors.grey600.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.dark_mode,
                        color: AppColors.grey600,
                        size: 20,
                      ),
                    ),
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Use dark theme'),
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor: AppColors.info.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.notifications,
                        color: AppColors.info,
                        size: 20,
                      ),
                    ),
                    title: const Text('Notifications'),
                    subtitle: const Text('Receive app notifications'),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Data & Storage
            Text(
              'Data & Storage',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.success.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.backup,
                        color: AppColors.success,
                        size: 20,
                      ),
                    ),
                    title: const Text('Export Data'),
                    subtitle: const Text('Export fuel tracking data'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _exportData,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.warning.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.restore,
                        color: AppColors.warning,
                        size: 20,
                      ),
                    ),
                    title: const Text('Import Data'),
                    subtitle: const Text('Import fuel tracking data'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _importData,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.error.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.delete_forever,
                        color: AppColors.error,
                        size: 20,
                      ),
                    ),
                    title: const Text('Clear All Data'),
                    subtitle: const Text('Delete all fuel entries'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showClearDataDialog,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // About
            Text(
              'About',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.info,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: const Text('App Version'),
                    subtitle: const Text('1.0.0'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showAboutDialog,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary.withValues(
                        alpha: 0.1,
                      ),
                      child: Icon(
                        Icons.help,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                    title: const Text('Help & Support'),
                    subtitle: const Text('Get help and support'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showHelp,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.accent.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.privacy_tip,
                        color: AppColors.accent,
                        size: 20,
                      ),
                    ),
                    title: const Text('Privacy Policy'),
                    subtitle: const Text('View privacy policy'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showPrivacyPolicy,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTankCapacityDialog() {
    final controller = TextEditingController(
      text: _tankCapacity.toStringAsFixed(1),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tank Capacity'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Capacity (Liters)',
                suffix: Text('L'),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final value = double.tryParse(controller.text);
                  if (value != null && value > 0) {
                    setState(() {
                      _tankCapacity = value;
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _showUnitDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Fuel Unit'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('Liters'),
                  value: 'Liters',
                  groupValue: _selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      _selectedUnit = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Gallons (US)'),
                  value: 'Gallons (US)',
                  groupValue: _selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      _selectedUnit = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Gallons (UK)'),
                  value: 'Gallons (UK)',
                  groupValue: _selectedUnit,
                  onChanged: (value) {
                    setState(() {
                      _selectedUnit = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _exportData() {
    // TODO: Implement data export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data export feature coming soon')),
    );
  }

  void _importData() {
    // TODO: Implement data import
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data import feature coming soon')),
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Clear All Data'),
            content: const Text(
              'This will permanently delete all your fuel entries. This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement data clearing
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All data cleared')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                child: const Text('Clear All'),
              ),
            ],
          ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Fuel Flow',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.local_gas_station,
          color: AppColors.white,
          size: 30,
        ),
      ),
      children: [
        const Text(
          'A modern Flutter application for OBD-II vehicle monitoring and fuel tracking.',
        ),
      ],
    );
  }

  void _showHelp() {
    // TODO: Implement help screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & Support feature coming soon')),
    );
  }

  void _showPrivacyPolicy() {
    // TODO: Implement privacy policy screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Privacy Policy feature coming soon')),
    );
  }
}
