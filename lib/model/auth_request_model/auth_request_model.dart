import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request_model.freezed.dart';
part 'auth_request_model.g.dart';

@freezed
class AuthRequestModel with _$AuthRequestModel {
  const factory AuthRequestModel({String? email, String? password}) =
      _AuthRequestModel;

  factory AuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestModelFromJson(json);
}
