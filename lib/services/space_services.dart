import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/services/firebase_base_services.dart';

class SpaceServices extends FirebaseBaseServices {
  Future<MyResponse> getSpacesByUserID({required String userID}) async {
    return callFirebaseDB(
      requestType: RequestType.get,
      dbCollection: DBCollectionName.space,
      filters: {'memberUserIDs': userID},
      arrayContainsFields: ['memberUserIDs'],
    );
  }

  Future<MyResponse> getSpaceDetails({required String spaceID}) async {
    return callFirebaseDB(
      requestType: RequestType.get,
      dbCollection: DBCollectionName.space,
      docID: spaceID,
    );
  }

  Future<MyResponse> addSpace({required SpaceModel spaceModel}) async {
    return callFirebaseDB(
      requestType: RequestType.post,
      dbCollection: DBCollectionName.space,
      postBody: spaceModel.toJson(),
    );
  }

  Future<MyResponse> joinSpaceWithInvitationCode({
    required String invitationCode,
    required String userID,
  }) async {
    return callFirebaseDB(
      requestType: RequestType.put,
      dbCollection: DBCollectionName.space,
      postBody: {
        'memberUserIDs': FieldValue.arrayUnion([userID]),
      },
      filters: {'invitationCode': invitationCode},
      updateByQuery: true,
    );
  }

  Future<MyResponse> updateSpace({
    required String spaceID,
    required SpaceModel spaceModel,
  }) async {
    return callFirebaseDB(
      requestType: RequestType.put,
      dbCollection: DBCollectionName.space,
      docID: spaceID,
      postBody: spaceModel.toJson(),
    );
  }

  Future<MyResponse> deleteSpace({required String spaceID}) async {
    return callFirebaseDB(
      requestType: RequestType.delete,
      dbCollection: DBCollectionName.space,
      docID: spaceID,
    );
  }

  Future<MyResponse> removeMemberOrLeaveSpace({
    required String spaceID,
    required String userID,
  }) async {
    return callFirebaseDB(
      requestType: RequestType.put,
      dbCollection: DBCollectionName.space,
      docID: spaceID,
      postBody: {
        'memberUserIDs': FieldValue.arrayRemove([userID]),
      },
    );
  }
}
