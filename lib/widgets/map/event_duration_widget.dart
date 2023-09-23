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
    var of = Theme.of(context);

    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;
    return FloatingActionButton.extended(
      heroTag: duration,
      onPressed: null,
      backgroundColor: color,
      label: Row(
        children: [
          // custom icon which is passed from the parent widget
          icon,

          // some space
          SizedBox(
            width: 2.w,
          ),

          // check if duration text is empty
          duration.isEmpty
              ?
              // circular progress indicator is shown
              SizedBox(
                  height: 8.sp,
                  width: 8.sp,
                  child: const CircularProgressIndicator(
                    color: Colors.white30,
                    strokeWidth: 1,
                  ),
                )
              :
              // else duration is not empty and the text is displayed
              Text(
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
