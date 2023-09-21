import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EventDurationWidget extends StatelessWidget {
  const EventDurationWidget({
    super.key,
    required this.duration,
  });

  final String duration;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    return FloatingActionButton.extended(
      heroTag: "2",
      onPressed: null,
      backgroundColor: Colors.grey,
      label: Row(
        children: [
          Icon(
            Icons.directions_walk_rounded,
            color: scaffoldBackgroundColor,
          ),
          duration.isEmpty
              ? SizedBox(
                  height: 8.sp,
                  width: 8.sp,
                  child: const CircularProgressIndicator(
                    color: Colors.white30,
                    strokeWidth: 1,
                  ),
                )
              : Text(
                  duration,
                  style: TextStyle(
                    color: scaffoldBackgroundColor,
                  ),
                ),
        ],
      ),
    );
  }
}
