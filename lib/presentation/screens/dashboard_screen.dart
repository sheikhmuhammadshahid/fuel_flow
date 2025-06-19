import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../providers/vehicle_data_provider.dart';
import '../widgets/gauge_widget.dart';
import '../widgets/quick_stats_card.dart';
import '../widgets/vehicle_data_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(connectionStateProvider);
    final currentVehicleData = ref.watch(currentVehicleDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status
            _buildConnectionStatus(context, connectionState),

            const SizedBox(height: 24),

            // Quick Stats Row
            Row(
              children: [
                Expanded(
                  child: QuickStatsCard(
                    title: 'Speed',
                    value:
                        currentVehicleData?.speed?.toStringAsFixed(0) ?? '--',
                    unit: 'km/h',
                    icon: Icons.speed,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: QuickStatsCard(
                    title: 'RPM',
                    value: currentVehicleData?.rpm?.toStringAsFixed(0) ?? '--',
                    unit: 'rpm',
                    icon: Icons.settings,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: QuickStatsCard(
                    title: 'Fuel Level',
                    value:
                        currentVehicleData?.fuelLevel?.toStringAsFixed(0) ??
                        '--',
                    unit: '%',
                    icon: Icons.local_gas_station,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: QuickStatsCard(
                    title: 'Engine Temp',
                    value:
                        currentVehicleData?.engineTemp?.toStringAsFixed(0) ??
                        '--',
                    unit: '°C',
                    icon: Icons.thermostat,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Gauges Section
            Text(
              'Live Gauges',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            // Speed and RPM Gauges
            Row(
              children: [
                Expanded(
                  child: GaugeWidget(
                    title: 'Speed',
                    value: currentVehicleData?.speed ?? 0,
                    maxValue: 200,
                    unit: 'km/h',
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GaugeWidget(
                    title: 'RPM',
                    value: currentVehicleData?.rpm ?? 0,
                    maxValue: 8000,
                    unit: 'rpm',
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Vehicle Data Section
            Text(
              'Vehicle Information',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),

            VehicleDataCard(
              title: 'Engine Data',
              data: {
                'Battery Voltage':
                    '${currentVehicleData?.batteryVoltage?.toStringAsFixed(1) ?? '--'} V',
                'Throttle Position':
                    '${currentVehicleData?.throttlePosition?.toStringAsFixed(0) ?? '--'}%',
                'Coolant Temperature':
                    '${currentVehicleData?.coolantTemp?.toStringAsFixed(0) ?? '--'}°C',
                'Intake Air Temperature':
                    '${currentVehicleData?.intakeAirTemp?.toStringAsFixed(0) ?? '--'}°C',
              },
            ),

            const SizedBox(height: 16),

            VehicleDataCard(
              title: 'Fuel System',
              data: {
                'Fuel Level':
                    '${currentVehicleData?.fuelLevel?.toStringAsFixed(0) ?? '--'}%',
                'Fuel Pressure':
                    '${currentVehicleData?.fuelPressure?.toStringAsFixed(1) ?? '--'} bar',
                'Fuel Trim (Short)':
                    '${currentVehicleData?.fuelTrimShort?.toStringAsFixed(1) ?? '--'}%',
                'Fuel Trim (Long)':
                    '${currentVehicleData?.fuelTrimLong?.toStringAsFixed(1) ?? '--'}%',
              },
            ),

            const SizedBox(height: 16),

            VehicleDataCard(
              title: 'Error Codes',
              data: {
                'Status':
                    currentVehicleData?.errorCodes.isEmpty == true
                        ? 'No active codes'
                        : '${currentVehicleData?.errorCodes.length} codes',
                'Last Check':
                    '${DateTime.now().difference(currentVehicleData?.timestamp ?? DateTime.now()).inMinutes} minutes ago',
              },
              isEmpty: currentVehicleData?.errorCodes.isEmpty == true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus(
    BuildContext context,
    OBDConnectionState connectionState,
  ) {
    final isConnected = connectionState.isConnected;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isConnected
                ? AppColors.success.withValues(alpha: 0.1)
                : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isConnected ? AppColors.success : AppColors.error,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
            color: isConnected ? AppColors.success : AppColors.error,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isConnected ? 'OBD-II Connected' : 'Not Connected',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: isConnected ? AppColors.success : AppColors.error,
                  ),
                ),
                if (isConnected && connectionState.connectedDeviceName != null)
                  Text(
                    connectionState.connectedDeviceName!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                if (connectionState.errorMessage != null)
                  Text(
                    connectionState.errorMessage!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),
          ),
          if (!isConnected)
            TextButton(
              onPressed: () {
                // Navigate to connection screen
              },
              child: const Text('Connect'),
            ),
        ],
      ),
    );
  }
}
