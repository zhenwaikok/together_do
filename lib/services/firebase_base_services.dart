import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/model/my_response.dart';

enum AuthType { signUp, login, logout }

enum RequestType { get, post, put, delete }

abstract class FirebaseBaseServices {
  Future<MyResponse> authenticate({
    required AuthType authType,
    Map<String, dynamic>? requestBody,
  }) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      switch (authType) {
        case AuthType.signUp:
          final userCredential = await auth.createUserWithEmailAndPassword(
            email: requestBody?['email'],
            password: requestBody?['password'],
          );
          return MyResponse.complete(userCredential.user);
        case AuthType.login:
          final userCredential = await auth.signInWithEmailAndPassword(
            email: requestBody?['email'],
            password: requestBody?['password'],
          );
          return MyResponse.complete(userCredential.user);
        case AuthType.logout:
          await auth.signOut();
          return MyResponse.complete(true);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return MyResponse.error(_handleFirebaseAuthError(e, false));
    } catch (e) {
      debugPrint(e.toString());
      return MyResponse.error('Unexpected error: $e');
    }
  }

  Future<MyResponse> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      debugPrint('user: $user');

      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email ?? '',
          password: oldPassword,
        );
        debugPrint('credential: $credential');
        final reauthenticated = await user.reauthenticateWithCredential(
          credential,
        );
        debugPrint('reauthenticated: $reauthenticated');
        if (reauthenticated.user != null) {
          await user.updatePassword(newPassword);
          debugPrint('Password updated successfully');
          return MyResponse.complete(true);
        }
      }
      return MyResponse.error(false);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return MyResponse.error(_handleFirebaseAuthError(e, true));
    } catch (e) {
      debugPrint('Update password error: ${e.toString()}');
      return MyResponse.error('Unexpected error: $e');
    }
  }

  Future<MyResponse> passwordReset({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      return MyResponse.complete(true);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return MyResponse.error(_handleFirebaseAuthError(e, true));
    } catch (e) {
      debugPrint('Password reset error: ${e.toString()}');
      return MyResponse.error('Unexpected error: $e');
    }
  }

  Future<MyResponse> uploadImage({
    required String storageRef,
    required List<File> images,
  }) async {
    try {
      final storageReference = FirebaseStorage.instance.ref();

      List<String> imageUrls = [];
      for (var img in images) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final imageRef = storageReference.child('$storageRef/$fileName.jpg');
        final uploadTask = await imageRef.putFile(img);
        final downloadURL = await uploadTask.ref.getDownloadURL();
        imageUrls.add(downloadURL);
      }

      if (imageUrls.length == 1) {
        return MyResponse.complete(imageUrls.first);
      }

      return MyResponse.complete(imageUrls);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return MyResponse.error('Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('Image upload error: ${e.toString()}');
      return MyResponse.error('Image upload failed: $e');
    }
  }

  Future<MyResponse> callFirebaseDB({
    required RequestType requestType,
    required String dbCollection,
    String? docID,
    Map<String, dynamic>? postBody,
    Map<String, dynamic>? filters,
    List<String>? arrayContainsFields,
    bool updateByQuery = false,
  }) async {
    try {
      final firebaseDB = FirebaseFirestore.instance;

      switch (requestType) {
        case RequestType.get:
          if (filters != null && filters.isNotEmpty) {
            Query query = firebaseDB.collection(dbCollection);
            filters.forEach((key, value) {
              if (arrayContainsFields != null &&
                  arrayContainsFields.contains(key)) {
                query = query.where(key, arrayContains: value);
              } else {
                query = query.where(key, isEqualTo: value);
              }
            });

            final snapshot = await query.get();
            final data = snapshot.docs.map((doc) => doc.data()).toList();
            return MyResponse.complete(data);
          } else {
            final snapshot = await firebaseDB
                .collection(dbCollection)
                .doc(docID)
                .get();
            return MyResponse.complete(snapshot.data());
          }
        case RequestType.post:
          if (docID != null) {
            await firebaseDB.collection(dbCollection).doc(docID).set(postBody!);
          } else {
            final docRef = firebaseDB.collection(dbCollection).doc();
            postBody?['id'] = docRef.id;
            await docRef.set(postBody!);
          }
          return MyResponse.complete(true);
        case RequestType.put:
          if (updateByQuery && filters != null && filters.isNotEmpty) {
            Query query = firebaseDB.collection(dbCollection);
            filters.forEach((key, value) {
              query = query.where(key, isEqualTo: value);
            });

            final snapshot = await query.get();

            if (snapshot.docs.isEmpty) {
              return MyResponse.complete(false);
            }

            final doc = snapshot.docs.first;
            await doc.reference.update(postBody!);
            return MyResponse.complete(true);
          } else {
            await firebaseDB
                .collection(dbCollection)
                .doc(docID)
                .update(postBody!);
            return MyResponse.complete(true);
          }
        case RequestType.delete:
          if (filters != null && filters.isNotEmpty) {
            Query query = firebaseDB.collection(dbCollection);
            filters.forEach((key, value) {
              query = query.where(key, isEqualTo: value);
            });

            final snapshot = await query.get();

            final batch = firebaseDB.batch();
            for (var doc in snapshot.docs) {
              batch.delete(doc.reference);
            }
            await batch.commit();

            return MyResponse.complete(true);
          } else {
            await firebaseDB.collection(dbCollection).doc(docID).delete();
            return MyResponse.complete(true);
          }
      }
    } on FirebaseException catch (e) {
      return MyResponse.error('Firebase error: ${e.message}');
    } catch (e) {
      return MyResponse.error(e);
    }
  }

  String _handleFirebaseAuthError(
    FirebaseAuthException e,
    bool isUpdatePassword,
  ) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format';
      case 'user-disabled':
        return 'User account is disabled';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'Email is already in use';
      case 'weak-password':
        return 'The password is too weak';
      case 'invalid-credential':
        return isUpdatePassword
            ? 'Incorrect current password, please try again'
            : 'Invalid email or password';
      case 'provider-already-linked':
        return 'This provider is already linked to the account';
      case 'credential-already-in-use':
        return 'This email is already linked to another account';
      case 'operation-not-allowed':
        return 'This sign-in method is not allowed';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
