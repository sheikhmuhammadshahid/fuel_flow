// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PricingPlanImpl _$$PricingPlanImplFromJson(Map<String, dynamic> json) =>
    _$PricingPlanImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      duration: $enumDecode(_$PlanDurationEnumMap, json['duration']),
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isPopular: json['isPopular'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      productId: json['productId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PricingPlanImplToJson(_$PricingPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'duration': _$PlanDurationEnumMap[instance.duration]!,
      'features': instance.features,
      'isPopular': instance.isPopular,
      'isActive': instance.isActive,
      'productId': instance.productId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PlanDurationEnumMap = {
  PlanDuration.weekly: 'weekly',
  PlanDuration.monthly: 'monthly',
  PlanDuration.yearly: 'yearly',
};
