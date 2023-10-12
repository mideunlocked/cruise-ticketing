import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../screens/event_screens/event_screen.dart';
import 'event_price_container.dart';
import 'status_tile.dart';
import 'ticket_detail_tile.dart';

class EventDetailBox extends StatelessWidget {
  const EventDetailBox({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    // edgeinstets for details tile
    var detailTileEdgeInsets = EdgeInsets.only(left: 6.w, right: 4.w);
    var isValid = event.isValid == true;

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
                      durationData: const {},
                      event: event,
                    ),
                  ),
                ),
                // event name text widget
                child: Text(
                  event.name,
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
            text: event.date.year.toString(),
          ),

          // event time text
          TicketDetailTile(
            edgeInsets: detailTileEdgeInsets,
            iconUrl: "clock",
            text: event.time.toString(),
          ),

          // event venue text
          TicketDetailTile(
            edgeInsets: detailTileEdgeInsets,
            iconUrl: "placeholder",
            text: event.venue,
          ),

          StatusTile(
            detailTileEdgeInsets: detailTileEdgeInsets,
            isValid: isValid,
          ),

          // event price and category container
          EventPriceContainer(
            detailTileEdgeInsets: detailTileEdgeInsets,
            event: event,
          ),
        ],
      ),
    );
  }
}
