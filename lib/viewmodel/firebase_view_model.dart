import 'dart:io';

import 'package:mpma_assignment/repository/firebase_repository.dart';
import 'package:mpma_assignment/viewmodel/base_view_model.dart';

class FirebaseViewModel extends BaseViewModel {
  FirebaseViewModel({required this.firebaseRepository});

  FirebaseRepository firebaseRepository;

  Future<dynamic> uploadImage({
    required String storageRef,
    required List<File> images,
  }) async {
    final response = await firebaseRepository.uploadPhoto(
      storageRef: storageRef,
      images: images,
    );

    checkError(response);
    return response.data;
  }
}
