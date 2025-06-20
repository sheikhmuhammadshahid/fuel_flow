import 'package:freezed_annotation/freezed_annotation.dart';

part 'pricing_plan.freezed.dart';
part 'pricing_plan.g.dart';

@freezed
class PricingPlan with _$PricingPlan {
  const factory PricingPlan({
    required String id,
    required String name,
    required String description,
    required double price,
    required PlanDuration duration,
    @Default([]) List<String> features,
    @Default(false) bool isPopular,
    @Default(true) bool isActive,
    String? productId, // For in-app purchases
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PricingPlan;

  factory PricingPlan.fromJson(Map<String, dynamic> json) =>
      _$PricingPlanFromJson(json);
}

enum PlanDuration {
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
}

extension PlanDurationExtension on PlanDuration {
  String get displayName {
    switch (this) {
      case PlanDuration.weekly:
        return 'Weekly';
      case PlanDuration.monthly:
        return 'Monthly';
      case PlanDuration.yearly:
        return 'Yearly';
    }
  }

  String get shortName {
    switch (this) {
      case PlanDuration.weekly:
        return 'week';
      case PlanDuration.monthly:
        return 'month';
      case PlanDuration.yearly:
        return 'year';
    }
  }

  int get durationInDays {
    switch (this) {
      case PlanDuration.weekly:
        return 7;
      case PlanDuration.monthly:
        return 30;
      case PlanDuration.yearly:
        return 365;
    }
  }
}

extension PricingPlanExtensions on PricingPlan {
  String get pricePerPeriod =>
      '\$${price.toStringAsFixed(2)}/${duration.shortName}';

  String get monthlyEquivalent {
    final monthlyPrice =
        duration == PlanDuration.yearly
            ? price / 12
            : duration == PlanDuration.weekly
            ? price * 4.33
            : price;
    return '\$${monthlyPrice.toStringAsFixed(2)}/month';
  }

  double get savingsPercentage {
    // Calculate savings compared to monthly plan
    const monthlyBasePrice = 9.99; // Base monthly price
    final thisMonthlyPrice =
        duration == PlanDuration.yearly
            ? price / 12
            : duration == PlanDuration.weekly
            ? price * 4.33
            : price;

    if (thisMonthlyPrice >= monthlyBasePrice) return 0;

    return ((monthlyBasePrice - thisMonthlyPrice) / monthlyBasePrice) * 100;
  }
}
