import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class SpaceMemberDetailsViewModel extends BaseViewModel {
  SpaceMemberDetailsViewModel({required this.userRepository});

  final UserRepository userRepository;

  bool get isLoggedIn => userRepository.isLoggedIn;
  UserModel? get user => userRepository.user;

  UserModel? _userDetails;
  UserModel? get userDetails => _userDetails;

  Future<void> getMemberDetails({
    required String userID,
    bool updateSharedPreference = true,
  }) async {
    final response = await userRepository.getUserDetails(
      userID: userID,
      updateSharedPrefenrence: updateSharedPreference,
    );

    if (response.data is UserModel) {
      _userDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }
}
