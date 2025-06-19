import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../core/app_theme.dart';

class FuelLevelGauge extends StatelessWidget {
  final double fuelLevel; // Percentage (0-100)
  final double tankCapacity; // Total tank capacity in liters

  const FuelLevelGauge({
    super.key,
    required this.fuelLevel,
    required this.tankCapacity,
  });

  @override
  Widget build(BuildContext context) {
    final currentLiters = (fuelLevel / 100) * tankCapacity;

    return SizedBox(
      height: 200,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: true,
            showTicks: true,
            axisLabelStyle: GaugeTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            majorTickStyle: MajorTickStyle(
              length: 8,
              thickness: 2,
              color: Theme.of(context).dividerColor,
            ),
            minorTickStyle: MinorTickStyle(
              length: 4,
              thickness: 1,
              color: Theme.of(context).dividerColor,
            ),
            axisLineStyle: AxisLineStyle(
              thickness: 0.15,
              cornerStyle: CornerStyle.bothCurve,
              color: AppColors.grey300,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 25,
                color: AppColors.error,
                startWidth: 0.15,
                endWidth: 0.15,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 25,
                endValue: 50,
                color: AppColors.warning,
                startWidth: 0.15,
                endWidth: 0.15,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 50,
                endValue: 100,
                color: AppColors.success,
                startWidth: 0.15,
                endWidth: 0.15,
                sizeUnit: GaugeSizeUnit.factor,
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: fuelLevel,
                needleColor: AppColors.grey700,
                knobStyle: KnobStyle(
                  color: AppColors.grey700,
                  borderColor: AppColors.white,
                  borderWidth: 2,
                ),
                tailStyle: TailStyle(
                  length: 0.2,
                  color: AppColors.grey700,
                  width: 4,
                ),
                needleLength: 0.7,
                needleStartWidth: 1,
                needleEndWidth: 4,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${fuelLevel.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _getFuelLevelColor(fuelLevel),
                      ),
                    ),
                    Text(
                      '${currentLiters.toStringAsFixed(1)} L',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    Text(
                      'of ${tankCapacity.toStringAsFixed(0)} L',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                angle: 90,
                positionFactor: 0.6,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getFuelLevelColor(double level) {
    if (level <= 25) return AppColors.error;
    if (level <= 50) return AppColors.warning;
    return AppColors.success;
  }
}
