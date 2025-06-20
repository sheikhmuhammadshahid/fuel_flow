import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/pricing_service.dart';
import '../../data/models/pricing_plan.dart';

// Pricing service provider
final pricingServiceProvider = Provider<PricingService>((ref) {
  return PricingService();
});

// All pricing plans provider
final pricingPlansProvider = FutureProvider<List<PricingPlan>>((ref) async {
  final pricingService = ref.watch(pricingServiceProvider);
  return await pricingService.getPricingPlans();
});

// Recommended plan provider
final recommendedPlanProvider = FutureProvider<PricingPlan?>((ref) async {
  final pricingService = ref.watch(pricingServiceProvider);
  return await pricingService.getRecommendedPlan();
});

// Plan by duration provider
final planByDurationProvider =
    FutureProvider.family<PricingPlan?, PlanDuration>((ref, duration) async {
      final pricingService = ref.watch(pricingServiceProvider);
      return await pricingService.getPlanByDuration(duration);
    });

// Trial info provider
final trialInfoProvider = Provider<Map<String, dynamic>>((ref) {
  final pricingService = ref.watch(pricingServiceProvider);
  return pricingService.getTrialInfo();
});

// Features comparison provider
final featuresComparisonProvider = Provider<Map<String, List<String>>>((ref) {
  final pricingService = ref.watch(pricingServiceProvider);
  return pricingService.getPlanFeaturesComparison();
});

// Selected plan provider
final selectedPlanProvider =
    StateNotifierProvider<SelectedPlanNotifier, PricingPlan?>((ref) {
      return SelectedPlanNotifier();
    });

class SelectedPlanNotifier extends StateNotifier<PricingPlan?> {
  SelectedPlanNotifier() : super(null);

  void selectPlan(PricingPlan plan) {
    state = plan;
  }

  void clearSelection() {
    state = null;
  }
}
