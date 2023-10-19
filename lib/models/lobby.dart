import 'package:cruise/helpers/date_time_formatting.dart';

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

  String getLastTimestamp() {
    DateTime timestamp = messages.last.timestamp;

    String lastTime = DateTimeFormatting.timeAgo(timestamp);

    return lastTime;
  }
}
