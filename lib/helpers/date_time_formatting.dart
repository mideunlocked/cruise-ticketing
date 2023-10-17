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
}
