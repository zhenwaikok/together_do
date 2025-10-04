import 'package:mpma_assignment/model/auth_request_model/auth_request_model.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/services/user_services.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';

class UserRepository {
  UserRepository({
    required this.sharedPreferenceHandler,
    required this.userServices,
  });

  final SharedPreferenceHandler sharedPreferenceHandler;
  final UserServices userServices;

  bool get isLoggedIn => sharedPreferenceHandler.getUser() != null;
  UserModel? get user => sharedPreferenceHandler.getUser();

  Future<MyResponse> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final authRequestModel = AuthRequestModel(email: email, password: password);

    final response = await userServices.signUpWithEmailPassword(
      authRequestModel: authRequestModel,
    );
    return response;
  }

  Future<MyResponse> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final authRequestModel = AuthRequestModel(email: email, password: password);

    final response = await userServices.loginWithEmailPassword(
      authRequestModel: authRequestModel,
    );
    return response;
  }

  Future<MyResponse> logout() async {
    final response = await userServices.logout();
    await sharedPreferenceHandler.removeAllSP();
    return response;
  }

  Future<MyResponse> updateAccountPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await userServices.updateAccountPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    return response;
  }

  Future<MyResponse> resetPassword({required String email}) async {
    final response = await userServices.resetPassword(email: email);
    return response;
  }

  Future<MyResponse> getUserDetails({
    required String userID,
    bool? updateSharedPrefenrence,
  }) async {
    final response = await userServices.getUserDetails(userID: userID);
    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      if (updateSharedPrefenrence == true) {
        await sharedPreferenceHandler.putUser(resultModel);
      }
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> addUser({required UserModel userModel}) async {
    final response = await userServices.addUser(userModel: userModel);
    if (response.error == null) {
      await sharedPreferenceHandler.putUser(userModel);
    }
    return MyResponse.complete(response.data);
  }

  Future<MyResponse> updateUserDetails({
    required String userID,
    required UserModel userModel,
  }) async {
    final response = await userServices.updateUserDetails(
      userID: userID,
      userModel: userModel,
    );
    if (response.error == null) {
      await sharedPreferenceHandler.putUser(userModel);
    }
    return MyResponse.complete(response.data);
  }
}
