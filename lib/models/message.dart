import 'reply.dart';

class Message {
  final String id;
  final String text;
  final Reply? reply;
  final String userId;
  final bool isDeleted;
  final String fileLink;
  final String deletedBy;
  final DateTime dateTime;
  final List<dynamic> isSeen;

  const Message({
    required this.id,
    required this.text,
    required this.reply,
    required this.isSeen,
    required this.userId,
    required this.fileLink,
    required this.isDeleted,
    required this.dateTime,
    required this.deletedBy,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"] as String,
      userId: json["userId"] as String,
      text: json["text"] as String,
      isSeen: json["isSeen"] as List<dynamic>,
      dateTime: DateTime.parse(json["date"].toString()),
      fileLink: json["fileLink"] as String,
      reply: Reply.fromJson(json["reply"] as Map<String, dynamic>),
      isDeleted: json["isDeleted"] as bool,
      deletedBy: json["deletedBy"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "text": text,
      "isSeen": isSeen,
      "dateTime": dateTime,
      "fileLink": fileLink,
      "reply": reply?.toJson() ?? {},
      "isDeleted": isDeleted,
      "deletedBy": deletedBy,
    };
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
