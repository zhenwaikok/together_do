// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userID: json['userID'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      gender: json['gender'] as String?,
      profileImageURL: json['profileImageURL'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'gender': instance.gender,
      'profileImageURL': instance.profileImageURL,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
