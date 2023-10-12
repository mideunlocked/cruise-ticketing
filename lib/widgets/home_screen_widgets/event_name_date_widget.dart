import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';

class EventNameAndDateWidget extends StatelessWidget {
  const EventNameAndDateWidget({
    super.key,
    required this.event,
    this.isStart = false,
    this.largeText = true,
  });

  // event passed date
  final Event event;
  // checks if column should align vertically from start or end
  final bool isStart;
  // check if the text requires a larger font or smaller font
  final bool largeText;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    // check device is in dark mode or light mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    // gets time from the passed data and splits it so we can have the
    //start time and ending time in a list
    var time = event.time.hour;

    // text span text style
    var dateTimeStyle = TextStyle(
      fontSize: largeText == true ? 8.sp : 7.sp,
      color: largeText != true ? Colors.black : Colors.white,
      fontWeight: FontWeight.w500,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isStart == false ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // date and time widget in a text span
        RichText(
          text: TextSpan(
            text: event.date.year.toString(),
            style: dateTimeStyle,
            children: <TextSpan>[
              TextSpan(text: " ~ $time", style: dateTimeStyle),
            ],
          ),
        ),

        // some spacing
        SizedBox(
          height: 0.5.h,
        ),

        // event name text widget
        SizedBox(
          width: 100.w,
          child: Text(
            event.name,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: largeText == true ? 14.sp : 10.sp,
              color: largeText == true ? Colors.white : primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
