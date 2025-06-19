import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_data.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class VehicleData extends HiveObject {
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final double? speed;

  @HiveField(2)
  final double? rpm;

  @HiveField(3)
  final double? engineTemp;

  @HiveField(4)
  final double? fuelLevel;

  @HiveField(5)
  final String? vin;

  @HiveField(6)
  final List<String> errorCodes;

  @HiveField(7)
  final double? batteryVoltage;

  @HiveField(8)
  final double? throttlePosition;

  @HiveField(9)
  final double? fuelPressure;

  @HiveField(10)
  final double? coolantTemp;

  @HiveField(11)
  final double? intakeAirTemp;

  @HiveField(12)
  final double? maf; // Mass Air Flow

  @HiveField(13)
  final double? fuelTrimShort;

  @HiveField(14)
  final double? fuelTrimLong;

  VehicleData({
    required this.timestamp,
    this.speed,
    this.rpm,
    this.engineTemp,
    this.fuelLevel,
    this.vin,
    this.errorCodes = const [],
    this.batteryVoltage,
    this.throttlePosition,
    this.fuelPressure,
    this.coolantTemp,
    this.intakeAirTemp,
    this.maf,
    this.fuelTrimShort,
    this.fuelTrimLong,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) =>
      _$VehicleDataFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDataToJson(this);

  VehicleData copyWith({
    DateTime? timestamp,
    double? speed,
    double? rpm,
    double? engineTemp,
    double? fuelLevel,
    String? vin,
    List<String>? errorCodes,
    double? batteryVoltage,
    double? throttlePosition,
    double? fuelPressure,
    double? coolantTemp,
    double? intakeAirTemp,
    double? maf,
    double? fuelTrimShort,
    double? fuelTrimLong,
  }) {
    return VehicleData(
      timestamp: timestamp ?? this.timestamp,
      speed: speed ?? this.speed,
      rpm: rpm ?? this.rpm,
      engineTemp: engineTemp ?? this.engineTemp,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      vin: vin ?? this.vin,
      errorCodes: errorCodes ?? this.errorCodes,
      batteryVoltage: batteryVoltage ?? this.batteryVoltage,
      throttlePosition: throttlePosition ?? this.throttlePosition,
      fuelPressure: fuelPressure ?? this.fuelPressure,
      coolantTemp: coolantTemp ?? this.coolantTemp,
      intakeAirTemp: intakeAirTemp ?? this.intakeAirTemp,
      maf: maf ?? this.maf,
      fuelTrimShort: fuelTrimShort ?? this.fuelTrimShort,
      fuelTrimLong: fuelTrimLong ?? this.fuelTrimLong,
    );
  }

  // Calculate fuel in liters based on tank capacity
  double? getFuelInLiters(double tankCapacity) {
    if (fuelLevel == null) return null;
    return (fuelLevel! / 100.0) * tankCapacity;
  }
}
