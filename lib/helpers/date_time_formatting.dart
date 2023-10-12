import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatting {
  static String formatDateTime(DateTime date) {
    // Format DateTime using a pattern
    String formattedDateTime = DateFormat.yMMMMEEEEd().format(date);

    return formattedDateTime;
  }

  static String formatTimeOfDay(TimeOfDay time) {
    return '${time.hour}:${time.minute} ${time.period.name}';
  }
}
