import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../widgets/fuel_entry_card.dart';
import '../widgets/fuel_level_gauge.dart';
import 'add_fuel_screen.dart';

class FuelTrackingScreen extends ConsumerWidget {
  const FuelTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fuel Tracking',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Show fuel history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Fuel Level
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Current Fuel Level',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const FuelLevelGauge(fuelLevel: 68.0, tankCapacity: 50.0),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFuelStat(
                          context,
                          'Remaining',
                          '34.0 L',
                          Icons.local_gas_station,
                          AppColors.primary,
                        ),
                        _buildFuelStat(
                          context,
                          'Range',
                          '~420 km',
                          Icons.route,
                          AppColors.secondary,
                        ),
                        _buildFuelStat(
                          context,
                          'Tank Size',
                          '50.0 L',
                          Icons.speed,
                          AppColors.accent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddFuelScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Fuel'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showAutoDetectionDialog(context);
                    },
                    icon: const Icon(Icons.auto_fix_high),
                    label: const Text('Auto Detect'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recent Fuel Entries
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Fuel Entries',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to full history
                  },
                  child: const Text('View All'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Fuel Entry List
            ..._getDemoFuelEntries().map(
              (entry) => FuelEntryCard(
                entry: entry,
                onTap: () {
                  // Navigate to entry details
                },
              ),
            ),

            const SizedBox(height: 24),

            // Fuel Statistics
            Text(
              'Fuel Statistics',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildStatRow(context, 'This Month', '156.4 L', '\$187.20'),
                    const Divider(),
                    _buildStatRow(
                      context,
                      'Last 30 Days',
                      '142.8 L',
                      '\$171.36',
                    ),
                    const Divider(),
                    _buildStatRow(
                      context,
                      'Average per Fill',
                      '38.2 L',
                      '\$45.84',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFuelStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String period,
    String liters,
    String cost,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            period,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            ),
          ),
          Row(
            children: [
              Text(
                liters,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                cost,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<FuelEntryData> _getDemoFuelEntries() {
    return [
      FuelEntryData(
        id: '1',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        liters: 45.2,
        cost: 54.24,
        location: 'Shell Station, Main St',
        isAutoDetected: false,
      ),
      FuelEntryData(
        id: '2',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        liters: 38.8,
        cost: 46.56,
        location: 'BP Station, Oak Ave',
        isAutoDetected: true,
      ),
      FuelEntryData(
        id: '3',
        timestamp: DateTime.now().subtract(const Duration(days: 12)),
        liters: 42.1,
        cost: 50.52,
        location: 'Esso Station, Park Rd',
        isAutoDetected: false,
      ),
    ];
  }

  void _showAutoDetectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Auto Detection'),
            content: const Text(
              'Auto detection will monitor your fuel level and automatically log refills when detected. '
              'Make sure your OBD-II device is connected.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Enable auto detection
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Auto detection enabled')),
                  );
                },
                child: const Text('Enable'),
              ),
            ],
          ),
    );
  }
}

class FuelEntryData {
  final String id;
  final DateTime timestamp;
  final double liters;
  final double? cost;
  final String? location;
  final bool isAutoDetected;

  FuelEntryData({
    required this.id,
    required this.timestamp,
    required this.liters,
    this.cost,
    this.location,
    required this.isAutoDetected,
  });
}
