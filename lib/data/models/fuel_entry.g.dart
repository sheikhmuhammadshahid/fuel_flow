// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelEntryAdapter extends TypeAdapter<FuelEntry> {
  @override
  final int typeId = 0;

  @override
  FuelEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelEntry(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      litersAdded: fields[2] as double,
      cost: fields[3] as double?,
      location: fields[4] as String?,
      odometer: fields[5] as double?,
      isAutoDetected: fields[6] as bool,
      notes: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FuelEntry obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.litersAdded)
      ..writeByte(3)
      ..write(obj.cost)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.odometer)
      ..writeByte(6)
      ..write(obj.isAutoDetected)
      ..writeByte(7)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelEntry _$FuelEntryFromJson(Map<String, dynamic> json) => FuelEntry(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      litersAdded: (json['litersAdded'] as num).toDouble(),
      cost: (json['cost'] as num?)?.toDouble(),
      location: json['location'] as String?,
      odometer: (json['odometer'] as num?)?.toDouble(),
      isAutoDetected: json['isAutoDetected'] as bool? ?? false,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$FuelEntryToJson(FuelEntry instance) => <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'litersAdded': instance.litersAdded,
      'cost': instance.cost,
      'location': instance.location,
      'odometer': instance.odometer,
      'isAutoDetected': instance.isAutoDetected,
      'notes': instance.notes,
    };
