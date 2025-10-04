// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthRequestModel _$AuthRequestModelFromJson(Map<String, dynamic> json) {
  return _AuthRequestModel.fromJson(json);
}

/// @nodoc
mixin _$AuthRequestModel {
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  /// Serializes this AuthRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthRequestModelCopyWith<AuthRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthRequestModelCopyWith<$Res> {
  factory $AuthRequestModelCopyWith(
    AuthRequestModel value,
    $Res Function(AuthRequestModel) then,
  ) = _$AuthRequestModelCopyWithImpl<$Res, AuthRequestModel>;
  @useResult
  $Res call({String? email, String? password});
}

/// @nodoc
class _$AuthRequestModelCopyWithImpl<$Res, $Val extends AuthRequestModel>
    implements $AuthRequestModelCopyWith<$Res> {
  _$AuthRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = freezed, Object? password = freezed}) {
    return _then(
      _value.copyWith(
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            password: freezed == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthRequestModelImplCopyWith<$Res>
    implements $AuthRequestModelCopyWith<$Res> {
  factory _$$AuthRequestModelImplCopyWith(
    _$AuthRequestModelImpl value,
    $Res Function(_$AuthRequestModelImpl) then,
  ) = __$$AuthRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? password});
}

/// @nodoc
class __$$AuthRequestModelImplCopyWithImpl<$Res>
    extends _$AuthRequestModelCopyWithImpl<$Res, _$AuthRequestModelImpl>
    implements _$$AuthRequestModelImplCopyWith<$Res> {
  __$$AuthRequestModelImplCopyWithImpl(
    _$AuthRequestModelImpl _value,
    $Res Function(_$AuthRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = freezed, Object? password = freezed}) {
    return _then(
      _$AuthRequestModelImpl(
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        password: freezed == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthRequestModelImpl implements _AuthRequestModel {
  const _$AuthRequestModelImpl({this.email, this.password});

  factory _$AuthRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthRequestModelImplFromJson(json);

  @override
  final String? email;
  @override
  final String? password;

  @override
  String toString() {
    return 'AuthRequestModel(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthRequestModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthRequestModelImplCopyWith<_$AuthRequestModelImpl> get copyWith =>
      __$$AuthRequestModelImplCopyWithImpl<_$AuthRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthRequestModelImplToJson(this);
  }
}

abstract class _AuthRequestModel implements AuthRequestModel {
  const factory _AuthRequestModel({
    final String? email,
    final String? password,
  }) = _$AuthRequestModelImpl;

  factory _AuthRequestModel.fromJson(Map<String, dynamic> json) =
      _$AuthRequestModelImpl.fromJson;

  @override
  String? get email;
  @override
  String? get password;

  /// Create a copy of AuthRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthRequestModelImplCopyWith<_$AuthRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
