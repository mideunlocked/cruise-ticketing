import 'reply.dart';

class Message {
  final String id;
  final String text;
  final Reply? reply;
  final String userId;
  final bool isDeleted;
  final String fileLink;
  final String deletedBy;
  final DateTime timestamp;
  final List<dynamic> isSeen;

  const Message({
    required this.id,
    required this.text,
    required this.reply,
    required this.isSeen,
    required this.userId,
    required this.fileLink,
    required this.isDeleted,
    required this.timestamp,
    required this.deletedBy,
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
      isDeleted: json["isDeleted"] as bool,
      deletedBy: json["deletedBy"] ?? "",
    );
  }

  bool checkIsMe(String adminId) {
    String uid = adminId;
    bool isMe = false;

    isMe = userId == uid;

    return isMe;
  }

  bool checkDeletedBy(String adminId) {
    if (deletedBy == adminId) {
      return true;
    }
    return false;
  }
}
