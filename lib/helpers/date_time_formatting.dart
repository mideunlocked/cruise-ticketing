import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeFormatting {
  static String formatDateTime(DateTime date) {
    // Format DateTime using a pattern
    String formattedDateTime = DateFormat.yMMMd().format(date);

    return formattedDateTime;
  }

  static String formatedTime(DateTime dateTime) {
    String time = DateFormat('h:mm a').format(dateTime);

    return time;
  }

  static String formatTimeOfDay(TimeOfDay time) {
    return '${time.hour}:${time.minute} ${time.period.name}';
  }

  static String timeAgo(DateTime dateTime) {
    var dateTimeAgo = timeago.format(dateTime, locale: "en_short");

    return dateTimeAgo;
  }

  static TimeOfDay stringToTimeOfDay(String timeString) {
    // Split the timeString into hours and minutes
    final List<String> parts = timeString.split(':');
    final List<String> firstPart = parts.first.split("(");
    final List<String> secondPart = parts.last.split(")");

    if (parts.length == 2) {
      final int hours = int.tryParse(firstPart[1]) ?? 0;
      final int minutes = int.tryParse(secondPart[0]) ?? 0;

      // print(
      //     "$timeString to time of day is ${TimeOfDay(hour: hours, minute: minutes)}");

      return TimeOfDay(hour: hours, minute: minutes);
    } else {
      // Handle the case where the string is not in the expected format.
      // You can throw an exception, return a default time, or handle it in another way.
      // For example, return TimeOfDay.now() to provide a default value.
      return TimeOfDay.now();
    }
  }
}
