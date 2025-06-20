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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Dashboard',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient:
            isConnected
                ? LinearGradient(
                  colors: [
                    AppColors.success.withOpacity(0.1),
                    AppColors.success.withOpacity(0.05),
                  ],
                )
                : LinearGradient(
                  colors: [
                    AppColors.error.withOpacity(0.1),
                    AppColors.error.withOpacity(0.05),
                  ],
                ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isConnected ? AppColors.success : AppColors.error,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (isConnected ? AppColors.success : AppColors.error)
                .withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isConnected ? AppColors.success : AppColors.error,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isConnected
                  ? Icons.bluetooth_connected
                  : Icons.bluetooth_disabled,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isConnected ? 'OBD-II Connected' : 'Not Connected',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isConnected ? AppColors.success : AppColors.error,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isConnected
                      ? connectionState.connectedDeviceName ??
                          'Device connected'
                      : 'Connect to view vehicle data',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.grey600,
                  ),
                ),
                if (connectionState.errorMessage != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    connectionState.errorMessage!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!isConnected)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to connection screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
