import 'dart:io';

import 'package:mpma_assignment/model/my_response.dart';
import 'package:mpma_assignment/services/firebase_base_services.dart';

class FirebaseServices extends FirebaseBaseServices {
  Future<MyResponse> uploadPhoto({
    required String storageRef,
    required List<File> images,
  }) async {
    return uploadImage(storageRef: storageRef, images: images);
  }
}
