import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../screens/event_screen.dart';
import 'about_host.dart';
import 'date_time_widget.dart';
import 'description_text_widget.dart';
import 'event_screen_title_widget.dart';
import 'location_venue_widget.dart';
import 'padded_widget_event_screen.dart';
import 'whos_going_widget.dart';

class About extends StatelessWidget {
  const About({
    super.key,
    required this.sizedBox,
    required this.widget,
  });

  final SizedBox sizedBox;
  final EventScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // widget contains some info about the host
        const AboutHost(),

        // some space
        sizedBox,

        // description header
        const PaddedWidgetEventScreen(
            child: EventScreenTitleWidget(title: "DESCRIPTION")),

        // some space
        SizedBox(
          height: 2.h,
        ),

        // description text
        DescriptionTextWidget(
            description: widget.eventData["description"] ?? ""),

        // some space
        sizedBox,

        // date and time widget
        DateTimeWidget(
          date: widget.eventData["date"] ?? "",
          time: widget.eventData["time"] ?? "",
        ),

        // location and venue widget
        LocationVenueWidget(
          venue: widget.eventData["venue"] ?? "",
          location: widget.eventData["address"] ?? "",
        ),

        // some space
        sizedBox,

        // who is going header
        const PaddedWidgetEventScreen(
          child: EventScreenTitleWidget(title: "WHO'S GOING"),
        ),

        // some space
        SizedBox(
          height: 2.h,
        ),

        // staggered profile image of people going
        const WhosGoing(),
      ],
    );
  }
}
