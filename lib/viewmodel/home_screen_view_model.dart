import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/repository/chore_repository.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class HomeScreenViewModel extends BaseViewModel {
  HomeScreenViewModel({
    required this.choreRepository,
    required this.spaceRepository,
  });

  final ChoreRepository choreRepository;
  final SpaceRepository spaceRepository;

  List<ChoreModel> _choreList = [];
  List<ChoreModel> get choreList => _choreList;

  List<SpaceModel> _spaceList = [];
  List<SpaceModel> get spaceList => _spaceList;

  Future<void> getChoresByUserID({required String userID}) async {
    final response = await choreRepository.getChoresByUserID(userID: userID);

    if (response.data is List<ChoreModel>) {
      _choreList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getSpaceByUserID({required String userID}) async {
    final response = await spaceRepository.getSpaceByUserID(userID: userID);

    if (response.data is List<SpaceModel>) {
      _spaceList = response.data;
      notifyListeners();
    }

    checkError(response);
  }
}
