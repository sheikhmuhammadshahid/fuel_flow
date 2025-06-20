import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String email,
    String? displayName,
    String? photoURL,
    @Default(false) bool isAnonymous,
    @Default(UserSubscription.free()) UserSubscription subscription,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    DateTime? freeTrialStartDate,
    DateTime? freeTrialEndDate,
    @Default(0) int deviceConnectionCount,
    @Default(false) bool hasUsedFreeTrial,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class UserSubscription with _$UserSubscription {
  const factory UserSubscription.free() = _Free;
  const factory UserSubscription.weekly({
    required DateTime startDate,
    required DateTime endDate,
    String? transactionId,
  }) = _Weekly;
  const factory UserSubscription.monthly({
    required DateTime startDate,
    required DateTime endDate,
    String? transactionId,
  }) = _Monthly;
  const factory UserSubscription.yearly({
    required DateTime startDate,
    required DateTime endDate,
    String? transactionId,
  }) = _Yearly;

  factory UserSubscription.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionFromJson(json);
}

extension UserModelExtensions on UserModel {
  bool get hasActiveSubscription {
    return subscription.when(
      free: () => false,
      weekly: (start, end, _) => DateTime.now().isBefore(end),
      monthly: (start, end, _) => DateTime.now().isBefore(end),
      yearly: (start, end, _) => DateTime.now().isBefore(end),
    );
  }

  bool get canConnectToDevice {
    // Can connect if has active subscription or free trial is still valid
    if (hasActiveSubscription) return true;

    if (freeTrialEndDate != null &&
        DateTime.now().isBefore(freeTrialEndDate!)) {
      return true;
    }

    return false;
  }

  bool get isInFreeTrial {
    if (freeTrialStartDate == null || freeTrialEndDate == null) return false;
    final now = DateTime.now();
    return now.isAfter(freeTrialStartDate!) && now.isBefore(freeTrialEndDate!);
  }

  int get freeTrialDaysRemaining {
    if (freeTrialEndDate == null) return 0;
    final now = DateTime.now();
    if (now.isAfter(freeTrialEndDate!)) return 0;
    return freeTrialEndDate!.difference(now).inDays;
  }

  String get subscriptionStatus {
    if (hasActiveSubscription) {
      return subscription.when(
        free: () => 'Free',
        weekly: (_, __, ___) => 'Weekly Premium',
        monthly: (_, __, ___) => 'Monthly Premium',
        yearly: (_, __, ___) => 'Yearly Premium',
      );
    }

    if (isInFreeTrial) {
      return 'Free Trial ($freeTrialDaysRemaining days left)';
    }

    return 'Free';
  }
}
