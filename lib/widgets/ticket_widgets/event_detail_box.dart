import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../helpers/distance_duration_helper.dart';
import '../../models/event.dart';
import '../../models/ticket.dart';
import '../../providers/event_provider.dart';
import '../../screens/event_screens/event_screen.dart';
import 'event_price_container.dart';
import 'status_tile.dart';
import 'ticket_detail_tile.dart';

class EventDetailBox extends StatefulWidget {
  const EventDetailBox({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  State<EventDetailBox> createState() => _EventDetailBoxState();
}

class _EventDetailBoxState extends State<EventDetailBox> {
  Event? event;
  Map<String, dynamic> durationData = {};

  @override
  void initState() {
    super.initState();

    var eventProvider = Provider.of<EventProvider>(context, listen: false);
    event = eventProvider.getEvent(widget.ticket.eventId);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    final eventLatLng = event?.latlng ?? {};

    durationData = await DistanceAndDuration.getDistanceDuration(
        eventLatLng["lat"] ?? "", eventLatLng["lng"] ?? "");
  }

  @override
  Widget build(BuildContext context) {
    // edgeinstets for details tile
    var detailTileEdgeInsets = EdgeInsets.only(left: 6.w, right: 4.w);
    var isValid = widget.ticket.status == true;

    // gets time from the passed data and splits it so we can have the
    //start time and ending time in a list
    var time = DateTimeFormatting.formatTimeOfDay(
      event?.startTime ?? TimeOfDay.now(),
    );
    var date = DateTimeFormatting.formatDateTime(
      event?.date ?? DateTime.now(),
    );

    return SizedBox(
      height: 32.h,
      child: Column(
        children: [
          // event name widget which on tap navigates to event screen
          Padding(
            padding: detailTileEdgeInsets,
            child: SizedBox(
              width: 90.w,
              child: InkWell(
                // on tap navigate to event screen
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => EventScreen(
                      durationData: durationData,
                      event: event!,
                    ),
                  ),
                ),
                // event name text widget
                child: Text(
                  event?.name ?? "",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    wordSpacing: 4.0,
                  ),
                ),
              ),
            ),
          ),

          // some space
          SizedBox(
            height: 2.h,
          ),

          // event date text
          TicketDetailTile(
            edgeInsets: detailTileEdgeInsets,
            iconUrl: "calendar",
            text: date,
          ),

          // event time text
          TicketDetailTile(
            edgeInsets: detailTileEdgeInsets,
            iconUrl: "clock",
            text: time,
          ),

          // event venue text
          TicketDetailTile(
            edgeInsets: detailTileEdgeInsets,
            iconUrl: "placeholder",
            text: event?.venue ?? "",
          ),

          StatusTile(
            detailTileEdgeInsets: detailTileEdgeInsets,
            isValid: isValid,
          ),

          // event price and category container
          EventPriceContainer(
            detailTileEdgeInsets: detailTileEdgeInsets,
            ticket: widget.ticket,
          ),
        ],
      ),
    );
  }
}
