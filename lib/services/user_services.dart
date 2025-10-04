import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/auth_request_model/auth_request_model.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/services/firebase_base_services.dart';

class UserServices extends FirebaseBaseServices {
  Future<MyResponse> signUpWithEmailPassword({
    required AuthRequestModel authRequestModel,
  }) {
    return authenticate(
      authType: AuthType.signUp,
      requestBody: authRequestModel.toJson(),
    );
  }

  Future<MyResponse> loginWithEmailPassword({
    required AuthRequestModel authRequestModel,
  }) {
    return authenticate(
      authType: AuthType.login,
      requestBody: authRequestModel.toJson(),
    );
  }

  Future<MyResponse> logout() {
    return authenticate(authType: AuthType.logout);
  }

  Future<MyResponse> updateAccountPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return updatePassword(oldPassword: oldPassword, newPassword: newPassword);
  }

  Future<MyResponse> resetPassword({required String email}) {
    return passwordReset(email: email);
  }

  Future<MyResponse> getUserDetails({required String userID}) async {
    return callFirebaseDB(
      requestType: RequestType.get,
      dbCollection: DBCollectionName.user,
      docID: userID,
    );
  }

  Future<MyResponse> addUser({required UserModel userModel}) async {
    return callFirebaseDB(
      requestType: RequestType.post,
      dbCollection: DBCollectionName.user,
      docID: userModel.userID,
      postBody: userModel.toJson(),
    );
  }

  Future<MyResponse> updateUserDetails({
    required String userID,
    required UserModel userModel,
  }) async {
    return callFirebaseDB(
      requestType: RequestType.put,
      dbCollection: DBCollectionName.user,
      docID: userID,
      postBody: userModel.toJson(),
    );
  }
}
