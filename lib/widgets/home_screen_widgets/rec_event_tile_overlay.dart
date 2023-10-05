import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'event_name_date_widget.dart';

class RecEventTileOverlay extends StatelessWidget {
  const RecEventTileOverlay({
    super.key,
    required this.data,
  });

  final dynamic data; // passed data

  @override
  Widget build(BuildContext context) {
    // tile overlay adding a shaded overlay to the bottom of image
    //also holds the even name, date and time

    return Container(
      height: 28.h,
      width: 100.w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black38],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 2.h,
      ),

      // event name and date widget
      child: EventNameAndDateWidget(data: data),
    );
  }
}
