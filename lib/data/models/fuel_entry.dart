import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fuel_entry.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class FuelEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final double litersAdded;

  @HiveField(3)
  final double? cost;

  @HiveField(4)
  final String? location;

  @HiveField(5)
  final double? odometer;

  @HiveField(6)
  final bool isAutoDetected;

  @HiveField(7)
  final String? notes;

  FuelEntry({
    required this.id,
    required this.timestamp,
    required this.litersAdded,
    this.cost,
    this.location,
    this.odometer,
    this.isAutoDetected = false,
    this.notes,
  });

  factory FuelEntry.fromJson(Map<String, dynamic> json) =>
      _$FuelEntryFromJson(json);

  Map<String, dynamic> toJson() => _$FuelEntryToJson(this);

  FuelEntry copyWith({
    String? id,
    DateTime? timestamp,
    double? litersAdded,
    double? cost,
    String? location,
    double? odometer,
    bool? isAutoDetected,
    String? notes,
  }) {
    return FuelEntry(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      litersAdded: litersAdded ?? this.litersAdded,
      cost: cost ?? this.cost,
      location: location ?? this.location,
      odometer: odometer ?? this.odometer,
      isAutoDetected: isAutoDetected ?? this.isAutoDetected,
      notes: notes ?? this.notes,
    );
  }
}
