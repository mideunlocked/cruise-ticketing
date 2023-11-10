import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppImageProvider with ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseStorage storageInstance = FirebaseStorage.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Future<dynamic> uploadProfileImage(File imageFile) async {
    String? uid = authInstance.currentUser?.uid;

    String path = "users/$uid";
    UploadTask uploadTask;

    try {
      final storagePath = storageInstance.ref().child(path);

      uploadTask = storagePath.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() {});

      return await snapshot.ref.getDownloadURL().then((value) {
        authInstance.currentUser?.updatePhotoURL(value);
        cloudInstance.collection("users").doc(uid).update({
          "imageUrl": value,
        });
      });
    } catch (e) {
      print("Profile image upload error: $e");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> uploadEventImage(File imageFile, String eventId) async {
    final path = "events/images/$eventId";
    UploadTask uploadTask;

    try {
      final storagePath = storageInstance.ref().child(path);

      uploadTask = storagePath.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() {});

      await snapshot.ref.getDownloadURL().then((value) {
        cloudInstance.collection("events").doc(eventId).update({
          "imageUrl": value,
        });
      });

      return true;
    } catch (e) {
      print("Upload image upload error: $e");
      notifyListeners();
      return "Error";
    }
  }

  Future<dynamic> uploadLobbyFile(
      File imageFile, String lobbyId, String messageId) async {
    final path = "lobbies/$lobbyId$messageId";
    UploadTask uploadTask;

    try {
      final storagePath = storageInstance.ref().child(path);

      uploadTask = storagePath.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() {});

      await snapshot.ref.getDownloadURL().then((value) {
        cloudInstance
            .collection("lobbies/$lobbyId/messages")
            .doc(messageId)
            .update({
          "fileLink": value,
        });
      });

      return true;
    } catch (e) {
      print("Lobby image upload error: $e");
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<dynamic> deleteImage(String path) async {
    print(path);
    try {
      await storageInstance.ref().child(path).delete();
    } catch (e) {
      print("Chat image upload error: $e");
      notifyListeners();
      return false;
    }
  }
}
