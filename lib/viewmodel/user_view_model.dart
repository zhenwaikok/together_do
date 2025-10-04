import 'package:firebase_auth/firebase_auth.dart';
import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  UserViewModel({required this.userRepository});

  final UserRepository userRepository;

  bool get isLoggedIn => userRepository.isLoggedIn;
  UserModel? get user => userRepository.user;

  UserModel? _userDetails;
  UserModel? get userDetails => _userDetails;

  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gender,
  }) async {
    UserModel userModel;

    final response = await userRepository.signUpWithEmailPassword(
      email: email,
      password: password,
    );

    if (response.data is User) {
      User user = response.data;

      userModel = UserModel(
        userID: user.uid,
        firstName: firstName,
        lastName: lastName,
        emailAddress: email,
        gender: gender,
        profileImageURL: null,
        createdDate: DateTime.now(),
      );

      await addUser(userModel: userModel);

      notifyListeners();
      checkError(response);
    }

    checkError(response);
  }

  Future<UserModel?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await userRepository.loginWithEmailPassword(
      email: email,
      password: password,
    );

    if (response.data is User) {
      await getUserDetails(userID: response.data.uid);
      return _userDetails;
    }

    checkError(response);
    return null;
  }

  Future<bool> logout() async {
    final response = await userRepository.logout();

    notifyListeners();

    checkError(response);
    return response.data;
  }

  Future<bool> updateAccountPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await userRepository.updateAccountPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    checkError(response);
    return response.data;
  }

  Future<bool> resetPassword({required String email}) async {
    final response = await userRepository.resetPassword(email: email);
    checkError(response);
    return response.data;
  }

  Future<void> addUser({required UserModel userModel}) async {
    final response = await userRepository.addUser(userModel: userModel);
    print('Add user response: ${response.data}');
    checkError(response);
  }

  Future<void> getUserDetails({
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

    print('User Details: $_userDetails');

    checkError(response);
  }

  Future<bool> updateUserDetails({
    required String userID,
    required String firstName,
    required String lastName,
    required String gender,
    String? newProfileImageURL,
  }) async {
    UserModel userModel = UserModel(
      userID: userID,
      firstName: firstName,
      lastName: lastName,
      emailAddress: _userDetails?.emailAddress,
      gender: gender,
      profileImageURL: newProfileImageURL ?? _userDetails?.profileImageURL,
      createdDate: _userDetails?.createdDate,
    );

    final response = await userRepository.updateUserDetails(
      userID: userID,
      userModel: userModel,
    );
    print('edit user response: ${response.data}');
    checkError(response);
    return response.data;
  }
}
