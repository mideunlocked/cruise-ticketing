import 'package:flutter/material.dart';

import '../models/lobby.dart';
import '../models/message.dart';

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
          timestamp: DateTime(2023, 10, 18, 2, 23),
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
          timestamp: DateTime(2023, 10, 19, 2, 26),
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
          timestamp: DateTime(2023, 10, 19, 2, 30),
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
          timestamp: DateTime(2023, 10, 19, 2, 35),
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
          timestamp: DateTime(
            2023,
            10,
            19,
            2,
            40,
          ),
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
  }

  void deleteMessage(String lobbyId, String messageId) {
    _lobbies
        .firstWhere((lobby) => lobby.id == lobbyId)
        .messages
        .removeWhere((message) => message.id == messageId);
  }

  void addReply(Reply reply) {
    bool checkIf;
    checkIf = _replies.any((e) => e.lobbyId == reply.lobbyId);

    if (checkIf) {
      updateReply(reply);
    } else {
      _replies.add(reply);
    }
  }

  void updateReply(Reply reply) {
    int oldReply;
    oldReply = _replies.indexWhere((e) => e.lobbyId == reply.lobbyId);

    _replies.insert(oldReply, reply);
  }

  void deleteReply(String lobbyId) {
    _replies.removeWhere((reply) => reply.lobbyId == lobbyId);
  }
}
