// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpaceModelImpl _$$SpaceModelImplFromJson(Map<String, dynamic> json) =>
    _$SpaceModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageURL: json['imageURL'] as String?,
      creatorUserID: json['creatorUserID'] as String?,
      invitationCode: json['invitationCode'] as String?,
      memberUserIDs: (json['memberUserIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      choreIDs: (json['choreIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SpaceModelImplToJson(_$SpaceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageURL': instance.imageURL,
      'creatorUserID': instance.creatorUserID,
      'invitationCode': instance.invitationCode,
      'memberUserIDs': instance.memberUserIDs,
      'choreIDs': instance.choreIDs,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
