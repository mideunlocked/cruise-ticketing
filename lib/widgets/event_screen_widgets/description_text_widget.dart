import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import 'padded_widget_event_screen.dart';

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.bold,
      // changes UI acccording to device theme mode
      color: MediaQuery.platformBrightnessOf(context) == Brightness.light
          ? Colors.green
          : const Color.fromARGB(255, 0, 255, 170).withOpacity(0.7),
    );

    return PaddedWidgetEventScreen(
      child: ReadMoreText(
        description,
        trimLines: 6,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: textStyle,
        lessStyle: textStyle,
      ),
    );
  }
}
