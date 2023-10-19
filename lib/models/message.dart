class Message {
  final String id;
  final String userId;
  final String text;
  final String fileLink;
  final DateTime timestamp;
  final List<dynamic> isSeen;
  final Reply? reply;

  const Message({
    required this.id,
    required this.userId,
    required this.text,
    required this.reply,
    required this.isSeen,
    required this.fileLink,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"] as String,
      userId: json["userId"] as String,
      text: json["text"] as String,
      isSeen: json["isSeen"] as List<dynamic>,
      timestamp: json["timestamp"] as DateTime,
      fileLink: json["fileLink"] as String,
      reply: json["reply"] as Reply,
    );
  }

  bool checkIsMe() {
    String uid = "0";
    bool isMe = false;

    isMe = userId == uid;

    return isMe;
  }
}

class Reply {
  final String text;
  final String lobbyId;
  final String fileLink;
  final String messageId;
  final String messageUserId;

  const Reply({
    required this.text,
    required this.lobbyId,
    required this.fileLink,
    required this.messageId,
    required this.messageUserId,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      text: json["text"] ?? "",
      lobbyId: json["lobbyId"] ?? "",
      fileLink: json["fileLink"] ?? "",
      messageId: json["messageId"] ?? "",
      messageUserId: json["messageUserId"] ?? "",
    );
  }
}
