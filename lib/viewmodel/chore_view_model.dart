import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/repository/chore_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class ChoreViewModel extends BaseViewModel {
  ChoreViewModel({required this.choreRepository});

  final ChoreRepository choreRepository;

  ChoreModel? _choreDetails;
  ChoreModel? get choreDetails => _choreDetails;

  List<ChoreModel> _choreList = [];
  List<ChoreModel> get choreList => _choreList;

  Future<void> getChoresBySpaceID({required String spaceID}) async {
    final response = await choreRepository.getChoresBySpaceID(spaceID: spaceID);

    if (response.data is List<ChoreModel>) {
      _choreList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getChoresByUserID({required String userID}) async {
    final response = await choreRepository.getChoresByUserID(userID: userID);

    if (response.data is List<ChoreModel>) {
      _choreList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getChoreDetails({required String choreID}) async {
    final response = await choreRepository.getChoreDetails(choreID: choreID);

    if (response.data is ChoreModel) {
      _choreDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> addChore({
    required String photoURL,
    required String title,
    required String description,
    required DateTime dueDate,
    required String assignedUserID,
    required String spaceID,
    required String creatorUserID,
  }) async {
    ChoreModel choreModel = ChoreModel(
      photoURL: photoURL,
      title: title,
      description: description,
      dueDate: dueDate,
      assignedUserID: assignedUserID,
      spaceID: spaceID,
      status: 'Pending',
      createdAt: DateTime.now(),
      creatorUserID: creatorUserID,
    );

    final response = await choreRepository.addChore(choreModel: choreModel);
    checkError(response);
    return response.data;
  }

  Future<bool> updateChore({
    required ChoreModel choreDetails,
    String? status,
    DateTime? completedAt,
  }) async {
    ChoreModel choreModel = ChoreModel(
      id: choreDetails.id,
      photoURL: choreDetails.photoURL,
      title: choreDetails.title,
      description: choreDetails.description,
      dueDate: choreDetails.dueDate,
      assignedUserID: choreDetails.assignedUserID,
      spaceID: choreDetails.spaceID,
      creatorUserID: choreDetails.creatorUserID,
      status: status ?? choreDetails.status,
      createdAt: choreDetails.createdAt,
      completedAt: completedAt,
    );

    final response = await choreRepository.updateChore(
      choreID: choreDetails.id ?? '',
      choreModel: choreModel,
    );
    checkError(response);
    return response.data;
  }

  Future<bool> deleteChore({
    String? spaceID,
    String? userID,
    String? choreID,
  }) async {
    final response = await choreRepository.deleteChore(
      spaceID: spaceID,
      userID: userID,
      choreID: choreID,
    );
    checkError(response);
    return response.data;
  }

  void clearChoreDetails() {
    _choreDetails = null;
  }
}
