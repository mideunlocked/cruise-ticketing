import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../screens/event_screens/event_screen.dart';
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
    // gets time from the passed data and splits it so we can have the
    //start time and ending time in a list
    var start = DateTimeFormatting.formatTimeOfDay(widget.event.startTime);
    var end = DateTimeFormatting.formatTimeOfDay(widget.event.endTime);
    var date = DateTimeFormatting.formatDateTime(widget.event.date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // widget contains some info about the host
        AboutHost(
          hostId: widget.event.hostId,
        ),

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
          description: widget.event.description,
        ),

        // some space
        sizedBox,

        // date and time widget
        DateTimeWidget(
          date: date,
          start: start,
          end: end,
        ),

        // location and venue widget
        LocationVenueWidget(
          venue: widget.event.venue,
          location: widget.event.address,
          latlng: widget.event.latlng,
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
        WhosGoing(
          attendees: widget.event.attendees,
        ),
      ],
    );
  }
}
