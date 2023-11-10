import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/lobby.dart';
import '../models/message.dart';
import '../models/reply.dart';
import 'image_provider.dart';

class LobbyProvider with ChangeNotifier {
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  final List<Lobby> _lobbies = [];
  final List<Reply> _replies = [];

  List<Lobby> get lobbies {
    return [..._lobbies];
  }

  List<Reply> get replies {
    return [..._replies];
  }

  Stream<QuerySnapshot> getLobbies() {
    String uid = authInstance.currentUser?.uid ?? "";
    try {
      var lobbyCollection = cloudInstance.collection("lobbies");

      Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = lobbyCollection
          .where(
            "attendees",
            arrayContains: uid,
          )
          .snapshots();

      return snapshot;
    } catch (e) {
      print("Get lobbies error: $e");
      notifyListeners();
      return Stream.error(e);
    }
  }

  Stream<QuerySnapshot> getLastMessage(String lobbyId) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = cloudInstance
          .collection("lobbies/$lobbyId/messages")
          .orderBy("dateTime", descending: true)
          .limit(1)
          .snapshots();

      return snapshot;
    } catch (e) {
      print("Get lobby last message error: $e");
      notifyListeners();
      return Stream.error(e);
    }
  }

  Stream<QuerySnapshot> getMessages(String lobbyId) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = cloudInstance
          .collection("lobbies/$lobbyId/messages")
          .orderBy("dateTime")
          .snapshots();

      return snapshot;
    } catch (e) {
      print("Get lobby messages error: $e");
      notifyListeners();
      return Stream.error(e);
    }
  }

  Future<dynamic> addMessage(String lobbyId, Message message) async {
    try {
      var lobbyCollection =
          cloudInstance.collection("lobbies/$lobbyId/messages");
      await lobbyCollection
          .add(
        message.toJson(),
      )
          .then((value) async {
        await lobbyCollection.doc(value.id).update({
          "id": value.id,
        });

        if (message.fileLink.isNotEmpty) {
          await AppImageProvider()
              .uploadLobbyFile(File(message.fileLink), lobbyId, value.id);
        }
      });

      return true;
    } catch (e) {
      print("Send lobby messages error: $e");
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<dynamic> deleteMessage(String lobbyId, String messageId) async {
    String uid = authInstance.currentUser?.uid ?? "";

    try {
      await cloudInstance
          .collection("lobbies/$lobbyId/messages")
          .doc(messageId)
          .update(
        {
          "isDeleted": true,
          "deletedBy": uid,
        },
      );
    } catch (e) {
      print("delete message error: $e");
      return Future.error(e);
    }
  }

  Reply getReplyData(String lobbyId) {
    return _replies.singleWhere((element) => element.lobbyId == lobbyId);
  }

  bool checkIfTheresReply(String lobbyId) {
    bool checkIf;
    checkIf = _replies.any((e) => e.lobbyId == lobbyId);

    return checkIf;
  }

  void addReply(Reply reply) {
    if (checkIfTheresReply(reply.lobbyId)) {
      updateReply(reply);
    } else {
      _replies.add(reply);
    }

    notifyListeners();
  }

  void updateReply(Reply reply) {
    int oldReply;
    oldReply = _replies.indexWhere((e) => e.lobbyId == reply.lobbyId);

    _replies.removeAt(oldReply);
    _replies.insert(oldReply, reply);

    notifyListeners();
  }

  void deleteReply(String lobbyId) {
    _replies.removeWhere((reply) => reply.lobbyId == lobbyId);

    notifyListeners();
  }
}
