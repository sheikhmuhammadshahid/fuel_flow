// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PricingPlan _$PricingPlanFromJson(Map<String, dynamic> json) {
  return _PricingPlan.fromJson(json);
}

/// @nodoc
mixin _$PricingPlan {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  PlanDuration get duration => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  bool get isPopular => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get productId =>
      throw _privateConstructorUsedError; // For in-app purchases
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PricingPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PricingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PricingPlanCopyWith<PricingPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricingPlanCopyWith<$Res> {
  factory $PricingPlanCopyWith(
          PricingPlan value, $Res Function(PricingPlan) then) =
      _$PricingPlanCopyWithImpl<$Res, PricingPlan>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double price,
      PlanDuration duration,
      List<String> features,
      bool isPopular,
      bool isActive,
      String? productId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PricingPlanCopyWithImpl<$Res, $Val extends PricingPlan>
    implements $PricingPlanCopyWith<$Res> {
  _$PricingPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PricingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? duration = null,
    Object? features = null,
    Object? isPopular = null,
    Object? isActive = null,
    Object? productId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as PlanDuration,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PricingPlanImplCopyWith<$Res>
    implements $PricingPlanCopyWith<$Res> {
  factory _$$PricingPlanImplCopyWith(
          _$PricingPlanImpl value, $Res Function(_$PricingPlanImpl) then) =
      __$$PricingPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double price,
      PlanDuration duration,
      List<String> features,
      bool isPopular,
      bool isActive,
      String? productId,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$PricingPlanImplCopyWithImpl<$Res>
    extends _$PricingPlanCopyWithImpl<$Res, _$PricingPlanImpl>
    implements _$$PricingPlanImplCopyWith<$Res> {
  __$$PricingPlanImplCopyWithImpl(
      _$PricingPlanImpl _value, $Res Function(_$PricingPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of PricingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? duration = null,
    Object? features = null,
    Object? isPopular = null,
    Object? isActive = null,
    Object? productId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PricingPlanImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as PlanDuration,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPopular: null == isPopular
          ? _value.isPopular
          : isPopular // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PricingPlanImpl implements _PricingPlan {
  const _$PricingPlanImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.duration,
      final List<String> features = const [],
      this.isPopular = false,
      this.isActive = true,
      this.productId,
      this.createdAt,
      this.updatedAt})
      : _features = features;

  factory _$PricingPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricingPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final PlanDuration duration;
  final List<String> _features;
  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  @JsonKey()
  final bool isPopular;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? productId;
// For in-app purchases
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PricingPlan(id: $id, name: $name, description: $description, price: $price, duration: $duration, features: $features, isPopular: $isPopular, isActive: $isActive, productId: $productId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricingPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      price,
      duration,
      const DeepCollectionEquality().hash(_features),
      isPopular,
      isActive,
      productId,
      createdAt,
      updatedAt);

  /// Create a copy of PricingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PricingPlanImplCopyWith<_$PricingPlanImpl> get copyWith =>
      __$$PricingPlanImplCopyWithImpl<_$PricingPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricingPlanImplToJson(
      this,
    );
  }
}

abstract class _PricingPlan implements PricingPlan {
  const factory _PricingPlan(
      {required final String id,
      required final String name,
      required final String description,
      required final double price,
      required final PlanDuration duration,
      final List<String> features,
      final bool isPopular,
      final bool isActive,
      final String? productId,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$PricingPlanImpl;

  factory _PricingPlan.fromJson(Map<String, dynamic> json) =
      _$PricingPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  PlanDuration get duration;
  @override
  List<String> get features;
  @override
  bool get isPopular;
  @override
  bool get isActive;
  @override
  String? get productId; // For in-app purchases
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PricingPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PricingPlanImplCopyWith<_$PricingPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
