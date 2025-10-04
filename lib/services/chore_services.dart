import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/services/firebase_base_services.dart';

class ChoreServices extends FirebaseBaseServices {
  Future<MyResponse> getChoresBySpaceID({required String spaceID}) async {
    return callFirebaseDB(
      requestType: RequestType.get,
      dbCollection: DBCollectionName.chore,
      filters: {'spaceID': spaceID},
    );
  }

  Future<MyResponse> getChoresByUserID({required String userID}) async {
    return callFirebaseDB(
      requestType: RequestType.get,
      dbCollection: DBCollectionName.chore,
      filters: {'assignedUserID': userID},
    );
  }

  Future<MyResponse> getChoreDetails({required String choreID}) async {
    return callFirebaseDB(
      requestType: RequestType.get,
      dbCollection: DBCollectionName.chore,
      docID: choreID,
    );
  }

  Future<MyResponse> addChore({required ChoreModel choreModel}) async {
    return callFirebaseDB(
      requestType: RequestType.post,
      dbCollection: DBCollectionName.chore,
      postBody: choreModel.toJson(),
    );
  }

  Future<MyResponse> updateChore({
    required String choreID,
    required ChoreModel choreModel,
  }) async {
    return callFirebaseDB(
      requestType: RequestType.put,
      dbCollection: DBCollectionName.chore,
      docID: choreID,
      postBody: choreModel.toJson(),
    );
  }

  Future<MyResponse> deleteChore({
    String? spaceID,
    String? userID,
    String? choreID,
  }) async {
    return callFirebaseDB(
      requestType: RequestType.delete,
      dbCollection: DBCollectionName.chore,
      docID: choreID,
      filters: {
        if (spaceID != null) 'spaceID': spaceID,
        if (userID != null) 'assignedUserID': userID,
      },
    );
  }
}
