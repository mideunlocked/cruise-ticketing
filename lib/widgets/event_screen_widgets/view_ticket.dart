import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/ticket.dart';
import '../../screens/ticket_screen.dart';

class ViewTicket extends StatelessWidget {
  const ViewTicket({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.6), // Glow color
            blurRadius: 20.0, // Spread of the glow
            spreadRadius: 2.0, // Spread radius
          ),
        ],
      ),
      child: FloatingActionButton(
        heroTag: "View ticket",
        tooltip: "View ticket",
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => TicketScreen(
                ticket: ticket,
              ),
            ),
          );
        },
        child: Image.asset(
          "assets/icons/tickets_white.png",
          height: 8.h,
          width: 8.w,
        ),
      ),
    );
  }
}
