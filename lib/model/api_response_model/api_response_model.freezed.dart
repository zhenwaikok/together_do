// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiResponseModel _$ApiResponseModelFromJson(Map<String, dynamic> json) {
  return _ApiResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ApiResponseModel {
  int? get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ApiResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseModelCopyWith<ApiResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseModelCopyWith<$Res> {
  factory $ApiResponseModelCopyWith(
    ApiResponseModel value,
    $Res Function(ApiResponseModel) then,
  ) = _$ApiResponseModelCopyWithImpl<$Res, ApiResponseModel>;
  @useResult
  $Res call({int? status, String? message});
}

/// @nodoc
class _$ApiResponseModelCopyWithImpl<$Res, $Val extends ApiResponseModel>
    implements $ApiResponseModelCopyWith<$Res> {
  _$ApiResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = freezed, Object? message = freezed}) {
    return _then(
      _value.copyWith(
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiResponseModelImplCopyWith<$Res>
    implements $ApiResponseModelCopyWith<$Res> {
  factory _$$ApiResponseModelImplCopyWith(
    _$ApiResponseModelImpl value,
    $Res Function(_$ApiResponseModelImpl) then,
  ) = __$$ApiResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? status, String? message});
}

/// @nodoc
class __$$ApiResponseModelImplCopyWithImpl<$Res>
    extends _$ApiResponseModelCopyWithImpl<$Res, _$ApiResponseModelImpl>
    implements _$$ApiResponseModelImplCopyWith<$Res> {
  __$$ApiResponseModelImplCopyWithImpl(
    _$ApiResponseModelImpl _value,
    $Res Function(_$ApiResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = freezed, Object? message = freezed}) {
    return _then(
      _$ApiResponseModelImpl(
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseModelImpl implements _ApiResponseModel {
  const _$ApiResponseModelImpl({this.status, this.message});

  factory _$ApiResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseModelImplFromJson(json);

  @override
  final int? status;
  @override
  final String? message;

  @override
  String toString() {
    return 'ApiResponseModel(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseModelImplCopyWith<_$ApiResponseModelImpl> get copyWith =>
      __$$ApiResponseModelImplCopyWithImpl<_$ApiResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseModelImplToJson(this);
  }
}

abstract class _ApiResponseModel implements ApiResponseModel {
  const factory _ApiResponseModel({final int? status, final String? message}) =
      _$ApiResponseModelImpl;

  factory _ApiResponseModel.fromJson(Map<String, dynamic> json) =
      _$ApiResponseModelImpl.fromJson;

  @override
  int? get status;
  @override
  String? get message;

  /// Create a copy of ApiResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseModelImplCopyWith<_$ApiResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
