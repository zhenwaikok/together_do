// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chore_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoreModelImpl _$$ChoreModelImplFromJson(Map<String, dynamic> json) =>
    _$ChoreModelImpl(
      id: json['id'] as String?,
      photoURL: json['photoURL'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      assignedUserID: json['assignedUserID'] as String?,
      spaceID: json['spaceID'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      creatorUserID: json['creatorUserID'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$ChoreModelImplToJson(_$ChoreModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'photoURL': instance.photoURL,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate?.toIso8601String(),
      'assignedUserID': instance.assignedUserID,
      'spaceID': instance.spaceID,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'creatorUserID': instance.creatorUserID,
      'completedAt': instance.completedAt?.toIso8601String(),
    };
