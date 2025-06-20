// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  UserSubscription get subscription => throw _privateConstructorUsedError;
  DateTime? get subscriptionStartDate => throw _privateConstructorUsedError;
  DateTime? get subscriptionEndDate => throw _privateConstructorUsedError;
  DateTime? get freeTrialStartDate => throw _privateConstructorUsedError;
  DateTime? get freeTrialEndDate => throw _privateConstructorUsedError;
  int get deviceConnectionCount => throw _privateConstructorUsedError;
  bool get hasUsedFreeTrial => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoURL,
      bool isAnonymous,
      UserSubscription subscription,
      DateTime? subscriptionStartDate,
      DateTime? subscriptionEndDate,
      DateTime? freeTrialStartDate,
      DateTime? freeTrialEndDate,
      int deviceConnectionCount,
      bool hasUsedFreeTrial,
      DateTime? createdAt,
      DateTime? lastLoginAt});

  $UserSubscriptionCopyWith<$Res> get subscription;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? isAnonymous = null,
    Object? subscription = null,
    Object? subscriptionStartDate = freezed,
    Object? subscriptionEndDate = freezed,
    Object? freeTrialStartDate = freezed,
    Object? freeTrialEndDate = freezed,
    Object? deviceConnectionCount = null,
    Object? hasUsedFreeTrial = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as UserSubscription,
      subscriptionStartDate: freezed == subscriptionStartDate
          ? _value.subscriptionStartDate
          : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionEndDate: freezed == subscriptionEndDate
          ? _value.subscriptionEndDate
          : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freeTrialStartDate: freezed == freeTrialStartDate
          ? _value.freeTrialStartDate
          : freeTrialStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freeTrialEndDate: freezed == freeTrialEndDate
          ? _value.freeTrialEndDate
          : freeTrialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceConnectionCount: null == deviceConnectionCount
          ? _value.deviceConnectionCount
          : deviceConnectionCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasUsedFreeTrial: null == hasUsedFreeTrial
          ? _value.hasUsedFreeTrial
          : hasUsedFreeTrial // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSubscriptionCopyWith<$Res> get subscription {
    return $UserSubscriptionCopyWith<$Res>(_value.subscription, (value) {
      return _then(_value.copyWith(subscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoURL,
      bool isAnonymous,
      UserSubscription subscription,
      DateTime? subscriptionStartDate,
      DateTime? subscriptionEndDate,
      DateTime? freeTrialStartDate,
      DateTime? freeTrialEndDate,
      int deviceConnectionCount,
      bool hasUsedFreeTrial,
      DateTime? createdAt,
      DateTime? lastLoginAt});

  @override
  $UserSubscriptionCopyWith<$Res> get subscription;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? isAnonymous = null,
    Object? subscription = null,
    Object? subscriptionStartDate = freezed,
    Object? subscriptionEndDate = freezed,
    Object? freeTrialStartDate = freezed,
    Object? freeTrialEndDate = freezed,
    Object? deviceConnectionCount = null,
    Object? hasUsedFreeTrial = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_$UserModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as UserSubscription,
      subscriptionStartDate: freezed == subscriptionStartDate
          ? _value.subscriptionStartDate
          : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionEndDate: freezed == subscriptionEndDate
          ? _value.subscriptionEndDate
          : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freeTrialStartDate: freezed == freeTrialStartDate
          ? _value.freeTrialStartDate
          : freeTrialStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freeTrialEndDate: freezed == freeTrialEndDate
          ? _value.freeTrialEndDate
          : freeTrialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceConnectionCount: null == deviceConnectionCount
          ? _value.deviceConnectionCount
          : deviceConnectionCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasUsedFreeTrial: null == hasUsedFreeTrial
          ? _value.hasUsedFreeTrial
          : hasUsedFreeTrial // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.uid,
      required this.email,
      this.displayName,
      this.photoURL,
      this.isAnonymous = false,
      this.subscription = const UserSubscription.free(),
      this.subscriptionStartDate,
      this.subscriptionEndDate,
      this.freeTrialStartDate,
      this.freeTrialEndDate,
      this.deviceConnectionCount = 0,
      this.hasUsedFreeTrial = false,
      this.createdAt,
      this.lastLoginAt});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  @JsonKey()
  final bool isAnonymous;
  @override
  @JsonKey()
  final UserSubscription subscription;
  @override
  final DateTime? subscriptionStartDate;
  @override
  final DateTime? subscriptionEndDate;
  @override
  final DateTime? freeTrialStartDate;
  @override
  final DateTime? freeTrialEndDate;
  @override
  @JsonKey()
  final int deviceConnectionCount;
  @override
  @JsonKey()
  final bool hasUsedFreeTrial;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoURL: $photoURL, isAnonymous: $isAnonymous, subscription: $subscription, subscriptionStartDate: $subscriptionStartDate, subscriptionEndDate: $subscriptionEndDate, freeTrialStartDate: $freeTrialStartDate, freeTrialEndDate: $freeTrialEndDate, deviceConnectionCount: $deviceConnectionCount, hasUsedFreeTrial: $hasUsedFreeTrial, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.subscriptionStartDate, subscriptionStartDate) ||
                other.subscriptionStartDate == subscriptionStartDate) &&
            (identical(other.subscriptionEndDate, subscriptionEndDate) ||
                other.subscriptionEndDate == subscriptionEndDate) &&
            (identical(other.freeTrialStartDate, freeTrialStartDate) ||
                other.freeTrialStartDate == freeTrialStartDate) &&
            (identical(other.freeTrialEndDate, freeTrialEndDate) ||
                other.freeTrialEndDate == freeTrialEndDate) &&
            (identical(other.deviceConnectionCount, deviceConnectionCount) ||
                other.deviceConnectionCount == deviceConnectionCount) &&
            (identical(other.hasUsedFreeTrial, hasUsedFreeTrial) ||
                other.hasUsedFreeTrial == hasUsedFreeTrial) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      displayName,
      photoURL,
      isAnonymous,
      subscription,
      subscriptionStartDate,
      subscriptionEndDate,
      freeTrialStartDate,
      freeTrialEndDate,
      deviceConnectionCount,
      hasUsedFreeTrial,
      createdAt,
      lastLoginAt);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String uid,
      required final String email,
      final String? displayName,
      final String? photoURL,
      final bool isAnonymous,
      final UserSubscription subscription,
      final DateTime? subscriptionStartDate,
      final DateTime? subscriptionEndDate,
      final DateTime? freeTrialStartDate,
      final DateTime? freeTrialEndDate,
      final int deviceConnectionCount,
      final bool hasUsedFreeTrial,
      final DateTime? createdAt,
      final DateTime? lastLoginAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoURL;
  @override
  bool get isAnonymous;
  @override
  UserSubscription get subscription;
  @override
  DateTime? get subscriptionStartDate;
  @override
  DateTime? get subscriptionEndDate;
  @override
  DateTime? get freeTrialStartDate;
  @override
  DateTime? get freeTrialEndDate;
  @override
  int get deviceConnectionCount;
  @override
  bool get hasUsedFreeTrial;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastLoginAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSubscription _$UserSubscriptionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'free':
      return _Free.fromJson(json);
    case 'weekly':
      return _Weekly.fromJson(json);
    case 'monthly':
      return _Monthly.fromJson(json);
    case 'yearly':
      return _Yearly.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'UserSubscription',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$UserSubscription {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        weekly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        monthly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Free value) free,
    required TResult Function(_Weekly value) weekly,
    required TResult Function(_Monthly value) monthly,
    required TResult Function(_Yearly value) yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Free value)? free,
    TResult? Function(_Weekly value)? weekly,
    TResult? Function(_Monthly value)? monthly,
    TResult? Function(_Yearly value)? yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Free value)? free,
    TResult Function(_Weekly value)? weekly,
    TResult Function(_Monthly value)? monthly,
    TResult Function(_Yearly value)? yearly,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this UserSubscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSubscriptionCopyWith<$Res> {
  factory $UserSubscriptionCopyWith(
          UserSubscription value, $Res Function(UserSubscription) then) =
      _$UserSubscriptionCopyWithImpl<$Res, UserSubscription>;
}

/// @nodoc
class _$UserSubscriptionCopyWithImpl<$Res, $Val extends UserSubscription>
    implements $UserSubscriptionCopyWith<$Res> {
  _$UserSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FreeImplCopyWith<$Res> {
  factory _$$FreeImplCopyWith(
          _$FreeImpl value, $Res Function(_$FreeImpl) then) =
      __$$FreeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FreeImplCopyWithImpl<$Res>
    extends _$UserSubscriptionCopyWithImpl<$Res, _$FreeImpl>
    implements _$$FreeImplCopyWith<$Res> {
  __$$FreeImplCopyWithImpl(_$FreeImpl _value, $Res Function(_$FreeImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$FreeImpl implements _Free {
  const _$FreeImpl({final String? $type}) : $type = $type ?? 'free';

  factory _$FreeImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreeImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserSubscription.free()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FreeImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        weekly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        monthly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        yearly,
  }) {
    return free();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
  }) {
    return free?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
    required TResult orElse(),
  }) {
    if (free != null) {
      return free();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Free value) free,
    required TResult Function(_Weekly value) weekly,
    required TResult Function(_Monthly value) monthly,
    required TResult Function(_Yearly value) yearly,
  }) {
    return free(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Free value)? free,
    TResult? Function(_Weekly value)? weekly,
    TResult? Function(_Monthly value)? monthly,
    TResult? Function(_Yearly value)? yearly,
  }) {
    return free?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Free value)? free,
    TResult Function(_Weekly value)? weekly,
    TResult Function(_Monthly value)? monthly,
    TResult Function(_Yearly value)? yearly,
    required TResult orElse(),
  }) {
    if (free != null) {
      return free(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FreeImplToJson(
      this,
    );
  }
}

abstract class _Free implements UserSubscription {
  const factory _Free() = _$FreeImpl;

  factory _Free.fromJson(Map<String, dynamic> json) = _$FreeImpl.fromJson;
}

/// @nodoc
abstract class _$$WeeklyImplCopyWith<$Res> {
  factory _$$WeeklyImplCopyWith(
          _$WeeklyImpl value, $Res Function(_$WeeklyImpl) then) =
      __$$WeeklyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime startDate, DateTime endDate, String? transactionId});
}

/// @nodoc
class __$$WeeklyImplCopyWithImpl<$Res>
    extends _$UserSubscriptionCopyWithImpl<$Res, _$WeeklyImpl>
    implements _$$WeeklyImplCopyWith<$Res> {
  __$$WeeklyImplCopyWithImpl(
      _$WeeklyImpl _value, $Res Function(_$WeeklyImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? transactionId = freezed,
  }) {
    return _then(_$WeeklyImpl(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyImpl implements _Weekly {
  const _$WeeklyImpl(
      {required this.startDate,
      required this.endDate,
      this.transactionId,
      final String? $type})
      : $type = $type ?? 'weekly';

  factory _$WeeklyImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyImplFromJson(json);

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? transactionId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserSubscription.weekly(startDate: $startDate, endDate: $endDate, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startDate, endDate, transactionId);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyImplCopyWith<_$WeeklyImpl> get copyWith =>
      __$$WeeklyImplCopyWithImpl<_$WeeklyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        weekly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        monthly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        yearly,
  }) {
    return weekly(startDate, endDate, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
  }) {
    return weekly?.call(startDate, endDate, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
    required TResult orElse(),
  }) {
    if (weekly != null) {
      return weekly(startDate, endDate, transactionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Free value) free,
    required TResult Function(_Weekly value) weekly,
    required TResult Function(_Monthly value) monthly,
    required TResult Function(_Yearly value) yearly,
  }) {
    return weekly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Free value)? free,
    TResult? Function(_Weekly value)? weekly,
    TResult? Function(_Monthly value)? monthly,
    TResult? Function(_Yearly value)? yearly,
  }) {
    return weekly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Free value)? free,
    TResult Function(_Weekly value)? weekly,
    TResult Function(_Monthly value)? monthly,
    TResult Function(_Yearly value)? yearly,
    required TResult orElse(),
  }) {
    if (weekly != null) {
      return weekly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyImplToJson(
      this,
    );
  }
}

abstract class _Weekly implements UserSubscription {
  const factory _Weekly(
      {required final DateTime startDate,
      required final DateTime endDate,
      final String? transactionId}) = _$WeeklyImpl;

  factory _Weekly.fromJson(Map<String, dynamic> json) = _$WeeklyImpl.fromJson;

  DateTime get startDate;
  DateTime get endDate;
  String? get transactionId;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyImplCopyWith<_$WeeklyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MonthlyImplCopyWith<$Res> {
  factory _$$MonthlyImplCopyWith(
          _$MonthlyImpl value, $Res Function(_$MonthlyImpl) then) =
      __$$MonthlyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime startDate, DateTime endDate, String? transactionId});
}

/// @nodoc
class __$$MonthlyImplCopyWithImpl<$Res>
    extends _$UserSubscriptionCopyWithImpl<$Res, _$MonthlyImpl>
    implements _$$MonthlyImplCopyWith<$Res> {
  __$$MonthlyImplCopyWithImpl(
      _$MonthlyImpl _value, $Res Function(_$MonthlyImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? transactionId = freezed,
  }) {
    return _then(_$MonthlyImpl(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyImpl implements _Monthly {
  const _$MonthlyImpl(
      {required this.startDate,
      required this.endDate,
      this.transactionId,
      final String? $type})
      : $type = $type ?? 'monthly';

  factory _$MonthlyImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyImplFromJson(json);

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? transactionId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserSubscription.monthly(startDate: $startDate, endDate: $endDate, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startDate, endDate, transactionId);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyImplCopyWith<_$MonthlyImpl> get copyWith =>
      __$$MonthlyImplCopyWithImpl<_$MonthlyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        weekly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        monthly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        yearly,
  }) {
    return monthly(startDate, endDate, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
  }) {
    return monthly?.call(startDate, endDate, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
    required TResult orElse(),
  }) {
    if (monthly != null) {
      return monthly(startDate, endDate, transactionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Free value) free,
    required TResult Function(_Weekly value) weekly,
    required TResult Function(_Monthly value) monthly,
    required TResult Function(_Yearly value) yearly,
  }) {
    return monthly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Free value)? free,
    TResult? Function(_Weekly value)? weekly,
    TResult? Function(_Monthly value)? monthly,
    TResult? Function(_Yearly value)? yearly,
  }) {
    return monthly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Free value)? free,
    TResult Function(_Weekly value)? weekly,
    TResult Function(_Monthly value)? monthly,
    TResult Function(_Yearly value)? yearly,
    required TResult orElse(),
  }) {
    if (monthly != null) {
      return monthly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyImplToJson(
      this,
    );
  }
}

abstract class _Monthly implements UserSubscription {
  const factory _Monthly(
      {required final DateTime startDate,
      required final DateTime endDate,
      final String? transactionId}) = _$MonthlyImpl;

  factory _Monthly.fromJson(Map<String, dynamic> json) = _$MonthlyImpl.fromJson;

  DateTime get startDate;
  DateTime get endDate;
  String? get transactionId;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyImplCopyWith<_$MonthlyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$YearlyImplCopyWith<$Res> {
  factory _$$YearlyImplCopyWith(
          _$YearlyImpl value, $Res Function(_$YearlyImpl) then) =
      __$$YearlyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime startDate, DateTime endDate, String? transactionId});
}

/// @nodoc
class __$$YearlyImplCopyWithImpl<$Res>
    extends _$UserSubscriptionCopyWithImpl<$Res, _$YearlyImpl>
    implements _$$YearlyImplCopyWith<$Res> {
  __$$YearlyImplCopyWithImpl(
      _$YearlyImpl _value, $Res Function(_$YearlyImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? transactionId = freezed,
  }) {
    return _then(_$YearlyImpl(
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlyImpl implements _Yearly {
  const _$YearlyImpl(
      {required this.startDate,
      required this.endDate,
      this.transactionId,
      final String? $type})
      : $type = $type ?? 'yearly';

  factory _$YearlyImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyImplFromJson(json);

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? transactionId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'UserSubscription.yearly(startDate: $startDate, endDate: $endDate, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlyImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startDate, endDate, transactionId);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlyImplCopyWith<_$YearlyImpl> get copyWith =>
      __$$YearlyImplCopyWithImpl<_$YearlyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() free,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        weekly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        monthly,
    required TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)
        yearly,
  }) {
    return yearly(startDate, endDate, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? free,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult? Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
  }) {
    return yearly?.call(startDate, endDate, transactionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? free,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        weekly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        monthly,
    TResult Function(
            DateTime startDate, DateTime endDate, String? transactionId)?
        yearly,
    required TResult orElse(),
  }) {
    if (yearly != null) {
      return yearly(startDate, endDate, transactionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Free value) free,
    required TResult Function(_Weekly value) weekly,
    required TResult Function(_Monthly value) monthly,
    required TResult Function(_Yearly value) yearly,
  }) {
    return yearly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Free value)? free,
    TResult? Function(_Weekly value)? weekly,
    TResult? Function(_Monthly value)? monthly,
    TResult? Function(_Yearly value)? yearly,
  }) {
    return yearly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Free value)? free,
    TResult Function(_Weekly value)? weekly,
    TResult Function(_Monthly value)? monthly,
    TResult Function(_Yearly value)? yearly,
    required TResult orElse(),
  }) {
    if (yearly != null) {
      return yearly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyImplToJson(
      this,
    );
  }
}

abstract class _Yearly implements UserSubscription {
  const factory _Yearly(
      {required final DateTime startDate,
      required final DateTime endDate,
      final String? transactionId}) = _$YearlyImpl;

  factory _Yearly.fromJson(Map<String, dynamic> json) = _$YearlyImpl.fromJson;

  DateTime get startDate;
  DateTime get endDate;
  String? get transactionId;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearlyImplCopyWith<_$YearlyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
