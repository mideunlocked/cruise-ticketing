import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';

class LobbyMessagesSeparator extends StatelessWidget {
  const LobbyMessagesSeparator({
    super.key,
    required this.value,
  });

  final DateTime value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Text(
          value.day == DateTime.now().day
              ? "Today"
              : value.day == DateTime.now().day - 1
                  ? "Yesterday"
                  : DateTimeFormatting.formatDateTime(value),
        ),
      ),
    );
  }
}
