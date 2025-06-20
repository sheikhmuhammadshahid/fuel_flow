import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/pricing_plan.dart';

class PricingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all available pricing plans
  Future<List<PricingPlan>> getPricingPlans() async {
    try {
      final querySnapshot =
          await _firestore
              .collection('pricing_plans')
              .where('isActive', isEqualTo: true)
              .orderBy('price')
              .get();

      return querySnapshot.docs
          .map((doc) => PricingPlan.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error getting pricing plans: $e');
      return _getDefaultPricingPlans();
    }
  }

  // Get default pricing plans (fallback)
  List<PricingPlan> _getDefaultPricingPlans() {
    return [
      const PricingPlan(
        id: 'weekly_plan',
        name: 'Weekly Premium',
        description: 'Perfect for short trips and testing',
        price: 2.99,
        duration: PlanDuration.weekly,
        features: [
          'Connect to OBD-II devices',
          'Real-time vehicle data',
          'Fuel tracking & analytics',
          'Trip logging',
          'Basic reports',
        ],
        productId: 'fuel_flow_weekly',
      ),
      const PricingPlan(
        id: 'monthly_plan',
        name: 'Monthly Premium',
        description: 'Most popular choice for regular users',
        price: 9.99,
        duration: PlanDuration.monthly,
        features: [
          'All Weekly features',
          'Advanced analytics',
          'Fuel efficiency insights',
          'Maintenance reminders',
          'Export data',
          'Priority support',
        ],
        isPopular: true,
        productId: 'fuel_flow_monthly',
      ),
      const PricingPlan(
        id: 'yearly_plan',
        name: 'Yearly Premium',
        description: 'Best value for long-term users',
        price: 79.99,
        duration: PlanDuration.yearly,
        features: [
          'All Monthly features',
          'Vehicle comparison',
          'Historical trends',
          'Multiple vehicle support',
          'Advanced filters',
          'Custom reporting',
          'API access',
        ],
        productId: 'fuel_flow_yearly',
      ),
    ];
  }

  // Initialize default pricing plans in Firestore
  Future<void> initializeDefaultPlans() async {
    try {
      final plans = _getDefaultPricingPlans();
      final batch = _firestore.batch();

      for (final plan in plans) {
        final docRef = _firestore.collection('pricing_plans').doc(plan.id);
        batch.set(docRef, plan.toJson());
      }

      await batch.commit();
      debugPrint('Default pricing plans initialized');
    } catch (e) {
      debugPrint('Error initializing default plans: $e');
    }
  }

  // Get plan by duration
  Future<PricingPlan?> getPlanByDuration(PlanDuration duration) async {
    final plans = await getPricingPlans();
    try {
      return plans.firstWhere((plan) => plan.duration == duration);
    } catch (e) {
      return null;
    }
  }

  // Get recommended plan
  Future<PricingPlan?> getRecommendedPlan() async {
    final plans = await getPricingPlans();
    try {
      return plans.firstWhere((plan) => plan.isPopular);
    } catch (e) {
      return plans.isNotEmpty ? plans.first : null;
    }
  }

  // Calculate savings
  double calculateSavings(PricingPlan yearlyPlan, PricingPlan monthlyPlan) {
    final yearlyMonthlyPrice = yearlyPlan.price / 12;
    final savings = monthlyPlan.price - yearlyMonthlyPrice;
    return savings > 0 ? savings : 0;
  }

  // Get savings percentage
  double getSavingsPercentage(PricingPlan plan) {
    return plan.savingsPercentage;
  }

  // Format price for display
  String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  // Get plan features comparison
  Map<String, List<String>> getPlanFeaturesComparison() {
    return {
      'Free Trial (5 Days)': [
        'Limited device connection',
        'Basic fuel tracking',
        'Simple reports',
      ],
      'Weekly Premium': [
        'Connect to OBD-II devices',
        'Real-time vehicle data',
        'Fuel tracking & analytics',
        'Trip logging',
        'Basic reports',
      ],
      'Monthly Premium': [
        'All Weekly features',
        'Advanced analytics',
        'Fuel efficiency insights',
        'Maintenance reminders',
        'Export data',
        'Priority support',
      ],
      'Yearly Premium': [
        'All Monthly features',
        'Vehicle comparison',
        'Historical trends',
        'Multiple vehicle support',
        'Advanced filters',
        'Custom reporting',
        'API access',
      ],
    };
  }

  // Get trial information
  Map<String, dynamic> getTrialInfo() {
    return {
      'duration': 5, // days
      'features': [
        'Connect to OBD-II devices',
        'Basic fuel tracking',
        'Real-time data monitoring',
        'Simple trip logging',
      ],
      'limitations': [
        'Limited to 5 days',
        'Basic features only',
        'No data export',
        'No advanced analytics',
      ],
    };
  }
}
