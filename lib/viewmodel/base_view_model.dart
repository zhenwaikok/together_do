import 'package:flutter/material.dart';
import 'package:mpma_assignment/model/api_response_model/api_response_model.dart';
import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/utils/mixins/check_mounted_mixin.dart';

/// A base class to unified all the required common fields and functions
/// Inherited with ChangeNotifier for Provider State Management
/// All inheriting classes will be able to access these values and features
class BaseViewModel with ChangeNotifier, CheckMountedMixin {
  /// A function that handles error responses from the API.
  /// It will throw an exception if there are any errors.
  /// Ensure to handle these exceptions with the [tryLoad] or [tryCatch] methods in the UI.
  void checkError(MyResponse response) {
    if (response.status == ResponseStatus.error) {
      if (response.error != null) {
        if (response.error is Map<String, dynamic>) {
          ApiResponseModel error = ApiResponseModel.fromJson(response.error);
          if (error.isUrgentError) {
            throw UrgentErrorException(
              error.message ??
                  'Oppss.. something went wrong. Please contact admin for assistance.',
            );
          }
          throw NormalErrorException(
            error.message ??
                'Oppss.. something went wrong. Please contact admin for assistance.',
          );
        }
      }

      if (response.error is String) {
        throw NormalErrorException(response.error as String);
      }
      throw NormalErrorException(
        'Oppss.. something went wrong. Please contact admin for assistance.',
      );
    }
  }

  @override
  void notifyListeners() {
    if (mounted) {
      super.notifyListeners();
    }
  }
}

class UrgentErrorException implements Exception {
  final String message;

  UrgentErrorException(this.message);
}

class NormalErrorException implements Exception {
  final String message;

  NormalErrorException(this.message);
}
