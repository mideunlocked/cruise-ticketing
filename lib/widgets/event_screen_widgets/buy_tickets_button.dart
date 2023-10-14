import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import 'ticket_pricing_dialog.dart';

class BuyTicketButton extends StatelessWidget {
  const BuyTicketButton({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

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
        tooltip: "Get ticket",
        backgroundColor: primaryColor,
        heroTag: "buy-ticket",
        onPressed: () => showBuyTicket(context),
        child: Image.asset(
          "assets/icons/ticket-office.png",
          height: 8.h,
          width: 8.w,
          color: Colors.white,
        ),
      ),
    );
  }

  // initiates a bottom sheet for ticket pricing and purchasing
  void showBuyTicket(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return TicketPricingDialog(
            event: event,
          );
        });
  }
}
