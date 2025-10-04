import 'dart:io';

import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/services/firebase_services.dart';

class FirebaseRepository {
  FirebaseRepository({required this.firebaseServices});
  final FirebaseServices firebaseServices;

  Future<MyResponse> uploadPhoto({
    required String storageRef,
    required List<File> images,
  }) async {
    final response = await firebaseServices.uploadPhoto(
      storageRef: storageRef,
      images: images,
    );
    return response;
  }
}
