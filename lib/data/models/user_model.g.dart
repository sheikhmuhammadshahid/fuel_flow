// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      subscription: json['subscription'] == null
          ? const UserSubscription.free()
          : UserSubscription.fromJson(
              json['subscription'] as Map<String, dynamic>),
      subscriptionStartDate: json['subscriptionStartDate'] == null
          ? null
          : DateTime.parse(json['subscriptionStartDate'] as String),
      subscriptionEndDate: json['subscriptionEndDate'] == null
          ? null
          : DateTime.parse(json['subscriptionEndDate'] as String),
      freeTrialStartDate: json['freeTrialStartDate'] == null
          ? null
          : DateTime.parse(json['freeTrialStartDate'] as String),
      freeTrialEndDate: json['freeTrialEndDate'] == null
          ? null
          : DateTime.parse(json['freeTrialEndDate'] as String),
      deviceConnectionCount:
          (json['deviceConnectionCount'] as num?)?.toInt() ?? 0,
      hasUsedFreeTrial: json['hasUsedFreeTrial'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'isAnonymous': instance.isAnonymous,
      'subscription': instance.subscription.toJson(),
      'subscriptionStartDate':
          instance.subscriptionStartDate?.toIso8601String(),
      'subscriptionEndDate': instance.subscriptionEndDate?.toIso8601String(),
      'freeTrialStartDate': instance.freeTrialStartDate?.toIso8601String(),
      'freeTrialEndDate': instance.freeTrialEndDate?.toIso8601String(),
      'deviceConnectionCount': instance.deviceConnectionCount,
      'hasUsedFreeTrial': instance.hasUsedFreeTrial,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
    };

_$FreeImpl _$$FreeImplFromJson(Map<String, dynamic> json) => _$FreeImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FreeImplToJson(_$FreeImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$WeeklyImpl _$$WeeklyImplFromJson(Map<String, dynamic> json) => _$WeeklyImpl(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      transactionId: json['transactionId'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WeeklyImplToJson(_$WeeklyImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'transactionId': instance.transactionId,
      'runtimeType': instance.$type,
    };

_$MonthlyImpl _$$MonthlyImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyImpl(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      transactionId: json['transactionId'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MonthlyImplToJson(_$MonthlyImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'transactionId': instance.transactionId,
      'runtimeType': instance.$type,
    };

_$YearlyImpl _$$YearlyImplFromJson(Map<String, dynamic> json) => _$YearlyImpl(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      transactionId: json['transactionId'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$YearlyImplToJson(_$YearlyImpl instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'transactionId': instance.transactionId,
      'runtimeType': instance.$type,
    };
