import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/event_screens/event_screen.dart';
import 'event_screen_title_widget.dart';
import 'features_grid_view.dart';
import 'padded_widget_event_screen.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.widget,
    required this.sizedBox,
  });

  final EventScreen widget;
  final SizedBox sizedBox;

  @override
  Widget build(BuildContext context) {
    List<dynamic> features = widget.eventData["features"] ?? "";

    return PaddedWidgetEventScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // some space
          SizedBox(
            height: 2.h,
          ),

          // rules header
          const EventScreenTitleWidget(title: "RULES"),

          // some space
          SizedBox(
            height: 2.h,
          ),

          // rules text
          Text(widget.eventData["rules"] ?? ""),

          // some space
          sizedBox,

          // features header
          const EventScreenTitleWidget(title: "FEATURES"),

          // grid of event features
          FeatureGridView(features: features),
        ],
      ),
    );
  }
}
