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

  factory Attendee.fromJson(Map<String, dynamic>? json) {
    return Attendee(
      price: json?["price"] ?? "",
      userId: json?["userId"] ?? "",
      ticketId: json?["ticketId"] ?? "",
      category: json?["category"] ?? "",
      isValidated: json?["isValidated"] ?? false,
      scannedTime: json?["scannedTime"] ?? DateTime.now(),
    );
  }

  String getTimeAgo() {
    String timeAgo;

    timeAgo = DateTimeFormatting.timeAgo(scannedTime ?? DateTime(3000));

    return timeAgo;
  }
}
