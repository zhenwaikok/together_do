import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class ProfileScreenViewModel extends BaseViewModel {
  ProfileScreenViewModel({required this.userRepository});

  final UserRepository userRepository;

  UserModel? _userDetails;
  UserModel? get userDetails => _userDetails;

  Future<void> getUserDetails({
    required String userID,
    bool updateSharedPrefenrence = true,
  }) async {
    final response = await userRepository.getUserDetails(
      userID: userID,
      updateSharedPrefenrence: updateSharedPrefenrence,
    );

    if (response.data is UserModel) {
      _userDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }
}
