import 'package:flutter/material.dart';

import '../models/lobby.dart';
import '../models/message.dart';
import '../models/reply.dart';

class LobbyProvider with ChangeNotifier {
  final List<Lobby> _lobbies = [
    Lobby(
      id: "0",
      eventId: "0",
      nickName: "Firemonester",
      messages: [
        Message(
          id: "0",
          userId: "0",
          text:
              "Welcome to the lobby attendees hope we have a great time at the event, I'm John your host for the event nice to meet you all",
          reply: null,
          isSeen: [
            "1",
            "3",
            "4"
                "6",
          ],
          fileLink: "",
          dateTime: DateTime(2023, 10, 18, 2, 23),
          isDeleted: false,
          deletedBy: "",
        ),
        Message(
          id: "1",
          userId: "1",
          text: "Hoping to have a good time",
          reply: null,
          isSeen: [
            "0",
            "3",
            "4"
                "6",
          ],
          fileLink: "",
          dateTime: DateTime(2023, 10, 19, 2, 26),
          isDeleted: false,
          deletedBy: "",
        ),
        Message(
          id: "2",
          userId: "2",
          text: "First time attending something like this excited",
          reply: null,
          isSeen: [
            "0",
            "3",
            "4"
                "6",
          ],
          fileLink: "",
          dateTime: DateTime(2023, 10, 19, 2, 30),
          isDeleted: false,
          deletedBy: "",
        ),
        Message(
          id: "3",
          userId: "3",
          text: "Hello John, I'm going to have a good time for sure",
          reply: const Reply(
            messageId: "0",
            messageUserId: "0",
            lobbyId: "0",
            fileLink: "",
            text:
                "Welcome to the lobby attendees hope we have a great time at the event, I'm John your host for the event nice to meet you all",
          ),
          isSeen: [
            "0",
            "3",
            "4"
                "6",
          ],
          fileLink: "",
          dateTime: DateTime(2023, 10, 19, 2, 35),
          isDeleted: false,
          deletedBy: "",
        ),
        Message(
          id: "4",
          userId: "4",
          text: "",
          reply: null,
          isSeen: [
            "0",
            "1",
            "3",
            "6",
          ],
          fileLink: "ks",
          dateTime: DateTime(2023, 10, 19, 2, 40),
          isDeleted: false,
          deletedBy: "",
        ),
      ],
    ),
  ];
  final List<Reply> _replies = [];

  List<Lobby> get lobbies {
    return [..._lobbies];
  }

  List<Reply> get replies {
    return [..._replies];
  }

  List<Message> getMessages(String lobbyId) {
    return _lobbies.firstWhere((lobby) => lobby.id == lobbyId).messages;
  }

  void addMessage(String lobbyId, Message message) {
    _lobbies.firstWhere((lobby) => lobby.id == lobbyId).messages.add(message);
    notifyListeners();
  }

  void deleteMessage(String lobbyId, String messageId) {
    _lobbies
        .firstWhere((lobby) => lobby.id == lobbyId)
        .messages
        .removeWhere((element) => element.id == messageId);

    notifyListeners();
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
