import 'package:cruise/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../models/ticket.dart';
import '../../providers/event_provider.dart';
import '../general_widgets/custom_image_error_widget.dart';
import '../general_widgets/custom_loading_indicator.dart';

class TicketListTile extends StatefulWidget {
  const TicketListTile({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  State<TicketListTile> createState() => _TicketListTileState();
}

class _TicketListTileState extends State<TicketListTile> {
  Event? event;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    var eventProvider = Provider.of<EventProvider>(context, listen: false);
    event = await eventProvider.getEvent(widget.ticket.eventId);
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    var isValid = widget.ticket.status == true;

    double imageWidth = 30.w;
    double imageHeight = 10.h;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => TicketScreen(ticket: widget.ticket),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 3.w,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                event?.imageUrl ?? "",
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CustomLoadingIndicator(
                    width: imageWidth,
                    height: imageHeight,
                  );
                },
                errorBuilder: (ctx, _, stacktrace) {
                  return SizedBox(
                    width: imageWidth,
                    child: const CustomImageErrorWidget(),
                  );
                },
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60.w,
                  child: Text(
                    event?.name ?? "",
                    style: bodyMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.ticket.category}: ",
                      style: bodyMedium,
                    ),
                    Text(
                      widget.ticket.price,
                      style: bodyMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status: ",
                      style: bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      isValid ? "Valid" : "Expired",
                      style: bodyMedium?.copyWith(
                        color: isValid ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
