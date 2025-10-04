import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_model.freezed.dart';
part 'api_response_model.g.dart';

@freezed
class ApiResponseModel with _$ApiResponseModel {
  const factory ApiResponseModel({int? status, String? message}) =
      _ApiResponseModel;

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseModelFromJson(json);
}

extension ApiResponseModelX on ApiResponseModel {
  bool get isUrgentError {
    return status == 401 || status == 500;
  }
}
