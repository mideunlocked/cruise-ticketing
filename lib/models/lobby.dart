import '../helpers/date_time_formatting.dart';
import 'message.dart';

class Lobby {
  final String id;
  final String eventId;
  final String nickName;
  final List<Message> messages;

  const Lobby({
    required this.id,
    required this.eventId,
    required this.messages,
    required this.nickName,
  });

  factory Lobby.fromJson(Map<String, dynamic> json) {
    final List<dynamic> messageList = json["messages"];
    final List<Message> parsedMessages = messageList
        .map((messageJson) =>
            Message.fromJson(messageJson as Map<String, dynamic>))
        .toList();

    return Lobby(
      id: json["id"] as String,
      eventId: json["eventId"] as String,
      messages: parsedMessages,
      nickName: json["nickName"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final List<dynamic> parsedMessages =
        messages.map((e) => e.toJson()).toList();

    return {
      "id": id,
      "eventId": eventId,
      "messages": parsedMessages,
      "nickName": nickName,
    };
  }

  String getLastTimestamp() {
    DateTime timestamp = messages.last.dateTime;

    String lastTime = DateTimeFormatting.timeAgo(timestamp);

    return lastTime;
  }
}
