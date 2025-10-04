import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/services/chore_services.dart';

class ChoreRepository {
  ChoreRepository({required this.choreServices});

  final ChoreServices choreServices;

  Future<MyResponse> getChoresBySpaceID({required String spaceID}) async {
    final response = await choreServices.getChoresBySpaceID(spaceID: spaceID);

    if (response.data is List) {
      final resultList = (response.data as List)
          .map((json) => ChoreModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultList);
    }

    return response;
  }

  Future<MyResponse> getChoresByUserID({required String userID}) async {
    final response = await choreServices.getChoresByUserID(userID: userID);

    if (response.data is List) {
      final resultList = (response.data as List)
          .map((json) => ChoreModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultList);
    }

    return response;
  }

  Future<MyResponse> getChoreDetails({required String choreID}) async {
    final response = await choreServices.getChoreDetails(choreID: choreID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = ChoreModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }

    return response;
  }

  Future<MyResponse> addChore({required ChoreModel choreModel}) async {
    final response = await choreServices.addChore(choreModel: choreModel);
    return MyResponse.complete(response.data);
  }

  Future<MyResponse> updateChore({
    required String choreID,
    required ChoreModel choreModel,
  }) async {
    final response = await choreServices.updateChore(
      choreID: choreID,
      choreModel: choreModel,
    );
    return MyResponse.complete(response.data);
  }

  Future<MyResponse> deleteChore({
    String? spaceID,
    String? userID,
    String? choreID,
  }) async {
    final response = await choreServices.deleteChore(
      spaceID: spaceID,
      userID: userID,
      choreID: choreID,
    );
    return MyResponse.complete(response.data);
  }
}
