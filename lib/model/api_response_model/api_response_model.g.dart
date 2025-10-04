// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseModelImpl _$$ApiResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$ApiResponseModelImpl(
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$$ApiResponseModelImplToJson(
  _$ApiResponseModelImpl instance,
) => <String, dynamic>{'status': instance.status, 'message': instance.message};
