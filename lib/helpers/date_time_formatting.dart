import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
}
