import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EventDurationWidget extends StatelessWidget {
  const EventDurationWidget({
    super.key,
    required this.duration,
    required this.icon,
    this.color = Colors.black54,
  });

  final String duration;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: duration,
      onPressed: null,
      backgroundColor: color,
      label: Row(
        children: [
          icon,
          SizedBox(
            width: 2.w,
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
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
        ],
      ),
    );
  }
}
