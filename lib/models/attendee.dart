import 'package:cruise/helpers/date_time_formatting.dart';

class Attendee {
  final String userId;
  final String ticketId;
  final String category;
  final String price;
  final bool isValidated;
  final DateTime? scannedTime;

  const Attendee({
    required this.price,
    required this.userId,
    required this.ticketId,
    required this.category,
    required this.isValidated,
    required this.scannedTime,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      price: json["price"] as String,
      userId: json["userId"] as String,
      ticketId: json["ticketId"] as String,
      category: json["category"] as String,
      isValidated: json["isValidated"] as bool,
      scannedTime: json["scannedTime"] as DateTime,
    );
  }

  String getTimeAgo() {
    String timeAgo;

    timeAgo = DateTimeFormatting.timeAgo(scannedTime ?? DateTime(3000));

    return timeAgo;
  }
}
