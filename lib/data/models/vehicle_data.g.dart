// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleDataAdapter extends TypeAdapter<VehicleData> {
  @override
  final int typeId = 1;

  @override
  VehicleData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleData(
      timestamp: fields[0] as DateTime,
      speed: fields[1] as double?,
      rpm: fields[2] as double?,
      engineTemp: fields[3] as double?,
      fuelLevel: fields[4] as double?,
      vin: fields[5] as String?,
      errorCodes: (fields[6] as List).cast<String>(),
      batteryVoltage: fields[7] as double?,
      throttlePosition: fields[8] as double?,
      fuelPressure: fields[9] as double?,
      coolantTemp: fields[10] as double?,
      intakeAirTemp: fields[11] as double?,
      maf: fields[12] as double?,
      fuelTrimShort: fields[13] as double?,
      fuelTrimLong: fields[14] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleData obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.speed)
      ..writeByte(2)
      ..write(obj.rpm)
      ..writeByte(3)
      ..write(obj.engineTemp)
      ..writeByte(4)
      ..write(obj.fuelLevel)
      ..writeByte(5)
      ..write(obj.vin)
      ..writeByte(6)
      ..write(obj.errorCodes)
      ..writeByte(7)
      ..write(obj.batteryVoltage)
      ..writeByte(8)
      ..write(obj.throttlePosition)
      ..writeByte(9)
      ..write(obj.fuelPressure)
      ..writeByte(10)
      ..write(obj.coolantTemp)
      ..writeByte(11)
      ..write(obj.intakeAirTemp)
      ..writeByte(12)
      ..write(obj.maf)
      ..writeByte(13)
      ..write(obj.fuelTrimShort)
      ..writeByte(14)
      ..write(obj.fuelTrimLong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleData _$VehicleDataFromJson(Map<String, dynamic> json) => VehicleData(
  timestamp: DateTime.parse(json['timestamp'] as String),
  speed: (json['speed'] as num?)?.toDouble(),
  rpm: (json['rpm'] as num?)?.toDouble(),
  engineTemp: (json['engineTemp'] as num?)?.toDouble(),
  fuelLevel: (json['fuelLevel'] as num?)?.toDouble(),
  vin: json['vin'] as String?,
  errorCodes:
      (json['errorCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  batteryVoltage: (json['batteryVoltage'] as num?)?.toDouble(),
  throttlePosition: (json['throttlePosition'] as num?)?.toDouble(),
  fuelPressure: (json['fuelPressure'] as num?)?.toDouble(),
  coolantTemp: (json['coolantTemp'] as num?)?.toDouble(),
  intakeAirTemp: (json['intakeAirTemp'] as num?)?.toDouble(),
  maf: (json['maf'] as num?)?.toDouble(),
  fuelTrimShort: (json['fuelTrimShort'] as num?)?.toDouble(),
  fuelTrimLong: (json['fuelTrimLong'] as num?)?.toDouble(),
);

Map<String, dynamic> _$VehicleDataToJson(VehicleData instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'speed': instance.speed,
      'rpm': instance.rpm,
      'engineTemp': instance.engineTemp,
      'fuelLevel': instance.fuelLevel,
      'vin': instance.vin,
      'errorCodes': instance.errorCodes,
      'batteryVoltage': instance.batteryVoltage,
      'throttlePosition': instance.throttlePosition,
      'fuelPressure': instance.fuelPressure,
      'coolantTemp': instance.coolantTemp,
      'intakeAirTemp': instance.intakeAirTemp,
      'maf': instance.maf,
      'fuelTrimShort': instance.fuelTrimShort,
      'fuelTrimLong': instance.fuelTrimLong,
    };
