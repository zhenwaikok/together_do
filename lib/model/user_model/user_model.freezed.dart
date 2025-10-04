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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String? get userID => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get emailAddress => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get profileImageURL => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;

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
  $Res call({
    String? userID,
    String? firstName,
    String? lastName,
    String? emailAddress,
    String? gender,
    String? profileImageURL,
    DateTime? createdDate,
  });
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
    Object? userID = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? emailAddress = freezed,
    Object? gender = freezed,
    Object? profileImageURL = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            userID: freezed == userID
                ? _value.userID
                : userID // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            emailAddress: freezed == emailAddress
                ? _value.emailAddress
                : emailAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileImageURL: freezed == profileImageURL
                ? _value.profileImageURL
                : profileImageURL // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdDate: freezed == createdDate
                ? _value.createdDate
                : createdDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? userID,
    String? firstName,
    String? lastName,
    String? emailAddress,
    String? gender,
    String? profileImageURL,
    DateTime? createdDate,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? emailAddress = freezed,
    Object? gender = freezed,
    Object? profileImageURL = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        userID: freezed == userID
            ? _value.userID
            : userID // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        emailAddress: freezed == emailAddress
            ? _value.emailAddress
            : emailAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileImageURL: freezed == profileImageURL
            ? _value.profileImageURL
            : profileImageURL // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdDate: freezed == createdDate
            ? _value.createdDate
            : createdDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    this.userID,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.gender,
    this.profileImageURL,
    this.createdDate,
  });

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String? userID;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? emailAddress;
  @override
  final String? gender;
  @override
  final String? profileImageURL;
  @override
  final DateTime? createdDate;

  @override
  String toString() {
    return 'UserModel(userID: $userID, firstName: $firstName, lastName: $lastName, emailAddress: $emailAddress, gender: $gender, profileImageURL: $profileImageURL, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.profileImageURL, profileImageURL) ||
                other.profileImageURL == profileImageURL) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userID,
    firstName,
    lastName,
    emailAddress,
    gender,
    profileImageURL,
    createdDate,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    final String? userID,
    final String? firstName,
    final String? lastName,
    final String? emailAddress,
    final String? gender,
    final String? profileImageURL,
    final DateTime? createdDate,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String? get userID;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get emailAddress;
  @override
  String? get gender;
  @override
  String? get profileImageURL;
  @override
  DateTime? get createdDate;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
