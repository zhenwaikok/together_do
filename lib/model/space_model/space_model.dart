import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_model.freezed.dart';
part 'space_model.g.dart';

@freezed
class SpaceModel with _$SpaceModel {
  const factory SpaceModel({
    String? id,
    String? name,
    String? description,
    String? imageURL,
    String? creatorUserID,
    String? invitationCode,
    List<String>? memberUserIDs,
    List<String>? choreIDs,
    DateTime? createdAt,
  }) = _SpaceModel;

  factory SpaceModel.fromJson(Map<String, dynamic> json) =>
      _$SpaceModelFromJson(json);
}
