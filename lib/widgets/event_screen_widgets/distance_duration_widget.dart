import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'padded_widget_event_screen.dart';

class DistanceDuration extends StatelessWidget {
  const DistanceDuration({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return PaddedWidgetEventScreen(
      child: Row(
        children: [
          const Icon(
            Icons.directions_walk_rounded,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            data["duration"] ?? "",
          ),
          const Spacer(),
          Image.asset(
            "assets/icons/distance.png",
            height: 5.h,
            width: 5.w,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            data["distance"] ?? "",
          ),
        ],
      ),
    );
  }
}
