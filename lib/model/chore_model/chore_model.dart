import 'package:freezed_annotation/freezed_annotation.dart';

part 'chore_model.freezed.dart';
part 'chore_model.g.dart';

@freezed
class ChoreModel with _$ChoreModel {
  const factory ChoreModel({
    String? id,
    String? photoURL,
    String? title,
    String? description,
    DateTime? dueDate,
    String? assignedUserID,
    String? spaceID,
    String? status,
    DateTime? createdAt,
    String? creatorUserID,
    DateTime? completedAt,
  }) = _ChoreModel;

  factory ChoreModel.fromJson(Map<String, dynamic> json) =>
      _$ChoreModelFromJson(json);
}
