import 'dart:math';

import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class SpaceViewModel extends BaseViewModel {
  SpaceViewModel({required this.spaceRepository});

  final SpaceRepository spaceRepository;

  List<SpaceModel> _spaceList = [];
  List<SpaceModel> get spaceList => _spaceList;

  SpaceModel? _spaceDetails;
  SpaceModel? get spaceDetails => _spaceDetails;

  Future<void> getSpaceByUserID({required String userID}) async {
    final response = await spaceRepository.getSpaceByUserID(userID: userID);

    if (response.data is List<SpaceModel>) {
      _spaceList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getSpaceDetails({required String spaceID}) async {
    final response = await spaceRepository.getSpaceDetails(spaceID: spaceID);

    if (response.data is SpaceModel) {
      _spaceDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> addSpace({
    required String spaceName,
    required String description,
    required String imageURL,
    required String creatorUserID,
  }) async {
    final invitationCode = generateInvitationCode();

    SpaceModel spaceModel = SpaceModel(
      name: spaceName,
      description: description,
      imageURL: imageURL,
      creatorUserID: creatorUserID,
      invitationCode: invitationCode,
      memberUserIDs: [creatorUserID],
      choreIDs: [],
      createdAt: DateTime.now(),
    );

    final response = await spaceRepository.addSpace(spaceModel: spaceModel);
    checkError(response);
    return response.data;
  }

  Future<bool> joinSpaceWithInvitationCode({
    required String invitationCode,
    required String userID,
  }) async {
    final response = await spaceRepository.joinSpaceWithInvitationCode(
      invitationCode: invitationCode,
      userID: userID,
    );
    checkError(response);
    return response.data;
  }

  Future<bool> updateSpace({
    required String spaceID,
    required String spaceName,
    required String description,
    required String imageURL,
  }) async {
    SpaceModel spaceModel = SpaceModel(
      id: spaceID,
      name: spaceName,
      description: description,
      imageURL: imageURL,
      creatorUserID: _spaceDetails?.creatorUserID,
      invitationCode: _spaceDetails?.invitationCode,
      memberUserIDs: _spaceDetails?.memberUserIDs,
      choreIDs: _spaceDetails?.choreIDs,
      createdAt: _spaceDetails?.createdAt,
    );

    final response = await spaceRepository.updateSpace(
      spaceID: spaceID,
      spaceModel: spaceModel,
    );
    checkError(response);
    return response.data;
  }

  Future<bool> deleteSpace({required String spaceID}) async {
    final response = await spaceRepository.deleteSpace(spaceID: spaceID);
    checkError(response);
    return response.data;
  }

  Future<bool> removeMemberOrLeaveSpace({
    required String spaceID,
    required String userID,
  }) async {
    final response = await spaceRepository.removeMemberOrLeaveSpace(
      spaceID: spaceID,
      userID: userID,
    );
    checkError(response);
    return response.data;
  }

  String generateInvitationCode() {
    final length = 6;
    final chars = Chars.chars;
    final rand = Random();
    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
