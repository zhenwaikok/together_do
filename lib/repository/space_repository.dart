import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/services/space_services.dart';

class SpaceRepository {
  SpaceRepository({required this.spaceServices});

  final SpaceServices spaceServices;

  Future<MyResponse> getSpaceByUserID({required String userID}) async {
    final response = await spaceServices.getSpacesByUserID(userID: userID);

    if (response.data is List) {
      final resultList = (response.data as List)
          .map((json) => SpaceModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultList);
    }

    return response;
  }

  Future<MyResponse> getSpaceDetails({required String spaceID}) async {
    final response = await spaceServices.getSpaceDetails(spaceID: spaceID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = SpaceModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> addSpace({required SpaceModel spaceModel}) async {
    final response = await spaceServices.addSpace(spaceModel: spaceModel);
    return MyResponse.complete(response.data);
  }

  Future<MyResponse> joinSpaceWithInvitationCode({
    required String invitationCode,
    required String userID,
  }) async {
    final response = await spaceServices.joinSpaceWithInvitationCode(
      invitationCode: invitationCode,
      userID: userID,
    );
    return MyResponse.complete(response.data);
  }

  Future<MyResponse> updateSpace({
    required String spaceID,
    required SpaceModel spaceModel,
  }) async {
    final response = await spaceServices.updateSpace(
      spaceID: spaceID,
      spaceModel: spaceModel,
    );
    return MyResponse.complete(response.data);
  }

  Future<MyResponse> deleteSpace({required String spaceID}) async {
    final response = await spaceServices.deleteSpace(spaceID: spaceID);
    return MyResponse.complete(response.data);
  }

  Future<MyResponse> removeMemberOrLeaveSpace({
    required String spaceID,
    required String userID,
  }) async {
    final response = await spaceServices.removeMemberOrLeaveSpace(
      spaceID: spaceID,
      userID: userID,
    );
    return MyResponse.complete(response.data);
  }
}
