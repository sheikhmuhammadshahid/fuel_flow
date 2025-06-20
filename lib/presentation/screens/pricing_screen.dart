import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../../data/models/pricing_plan.dart';
import '../../data/models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/pricing_provider.dart';
import '../widgets/pricing_card.dart';

class PricingScreen extends ConsumerWidget {
  final bool showCloseButton;

  const PricingScreen({super.key, this.showCloseButton = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pricingPlansAsync = ref.watch(pricingPlansProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Choose Your Plan',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: AppColors.grey900,
          ),
        ),
        automaticallyImplyLeading: showCloseButton,
        iconTheme: IconThemeData(color: AppColors.grey900),
        actions: [
          if (!showCloseButton)
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Skip',
                style: GoogleFonts.inter(
                  color: AppColors.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      body: pricingPlansAsync.when(
        data: (plans) => _buildPricingContent(context, ref, plans),
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load pricing plans',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.grey600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => ref.refresh(pricingPlansProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildPricingContent(
    BuildContext context,
    WidgetRef ref,
    List<PricingPlan> plans,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section with gradient background
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.gradientStart.withOpacity(0.1),
                  AppColors.gradientEnd.withOpacity(0.05),
                ],
              ),
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unlock Premium Features',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Get full access to vehicle diagnostics, advanced analytics, and more.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Free Trial Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.1),
                        AppColors.secondary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.star, size: 32, color: AppColors.primary),
                      const SizedBox(height: 8),
                      Text(
                        'Start Your Free Trial',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '5 days of full access • No credit card required',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.grey600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Pricing Plans
                ...plans.map(
                  (plan) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PricingCard(
                      plan: plan,
                      onSelect: () => _handlePlanSelection(context, ref, plan),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Features Comparison
                _buildFeaturesComparison(ref),

                const SizedBox(height: 32),

                // Terms and Privacy
                _buildTermsAndPrivacy(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesComparison(WidgetRef ref) {
    final featuresComparison = ref.watch(featuresComparisonProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Feature Comparison',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey200),
          ),
          child: Column(
            children:
                featuresComparison.entries.map((entry) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.grey200,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...entry.value.map(
                          (feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: AppColors.success,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: AppColors.grey600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Column(
      children: [
        Text(
          'By continuing, you agree to our Terms of Service and Privacy Policy. '
          'Subscriptions automatically renew unless cancelled 24 hours before renewal.',
          style: GoogleFonts.inter(fontSize: 12, color: AppColors.grey500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                // Open Terms of Service
              },
              child: Text(
                'Terms of Service',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Open Privacy Policy
              },
              child: Text(
                'Privacy Policy',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handlePlanSelection(
    BuildContext context,
    WidgetRef ref,
    PricingPlan plan,
  ) {
    // Select the plan
    ref.read(selectedPlanProvider.notifier).selectPlan(plan);

    // Show purchase confirmation dialog
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Purchase'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You are about to purchase:'),
                const SizedBox(height: 8),
                Text(
                  plan.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(plan.pricePerPeriod),
                const SizedBox(height: 16),
                const Text(
                  'This will give you full access to all premium features.',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _processPurchase(context, ref, plan);
                },
                child: const Text('Purchase'),
              ),
            ],
          ),
    );
  }

  void _processPurchase(BuildContext context, WidgetRef ref, PricingPlan plan) {
    // TODO: Implement actual purchase logic with in-app purchases
    // For now, simulate successful purchase
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Purchase successful! Welcome to ${plan.name}'),
        backgroundColor: AppColors.success,
      ),
    );

    // Update user subscription
    final now = DateTime.now();
    final endDate = now.add(Duration(days: plan.duration.durationInDays));

    UserSubscription subscription;
    switch (plan.duration) {
      case PlanDuration.weekly:
        subscription = UserSubscription.weekly(
          startDate: now,
          endDate: endDate,
          transactionId:
              'demo_transaction_${DateTime.now().millisecondsSinceEpoch}',
        );
        break;
      case PlanDuration.monthly:
        subscription = UserSubscription.monthly(
          startDate: now,
          endDate: endDate,
          transactionId:
              'demo_transaction_${DateTime.now().millisecondsSinceEpoch}',
        );
        break;
      case PlanDuration.yearly:
        subscription = UserSubscription.yearly(
          startDate: now,
          endDate: endDate,
          transactionId:
              'demo_transaction_${DateTime.now().millisecondsSinceEpoch}',
        );
        break;
    }

    ref.read(authStateProvider.notifier).updateSubscription(subscription);

    // Navigate back
    Navigator.of(context).pop();
  }
}
