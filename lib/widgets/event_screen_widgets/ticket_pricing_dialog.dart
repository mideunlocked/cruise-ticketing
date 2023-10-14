import 'package:cruise/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../providers/ticket_provider.dart';
import '../general_widgets/custom_button.dart';
import 'pricing_widget.dart';
import 'purchase_status_widget.dart';

class TicketPricingDialog extends StatefulWidget {
  const TicketPricingDialog({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<TicketPricingDialog> createState() => _TicketPricingDialogState();
}

class _TicketPricingDialogState extends State<TicketPricingDialog> {
  // holds the selected price index
  var selectedIndex = -1;

  // holds the selected price
  String selectedPrice = "";

  String selectedCatgeory = "";

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    var pricing = widget.event.pricing;

    return Container(
      height: double.infinity,
      color: scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // some space
          SizedBox(
            height: 2.h,
          ),

          // buy ticket title
          Text(
            "Buy Ticket",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: primaryColor,
              letterSpacing: 2.0,
            ),
          ),

          // some space
          SizedBox(
            height: 1.h,
          ),

          // list of prices and categories
          Expanded(
            child: ListView.builder(
              itemCount: pricing.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  if (!pricing[index].isSoldOut()) {
                    if (selectedIndex == index) {
                      setState(() {
                        selectedIndex = -1;
                        selectedPrice = "";
                        selectedCatgeory = "";
                      });
                    } else {
                      setState(() {
                        selectedIndex = index; // pass currently selected index
                        selectedPrice = pricing[index]
                            .price
                            .toString(); // pass currently selected price
                        selectedCatgeory = pricing[index]
                            .category; // pass currently selected category
                      });
                    }
                  }
                },

                // category and price widget
                child: PricingWidget(
                  price: pricing[index],
                  selectedIndex: selectedIndex,
                  index: index,
                ),
              ),
            ),
          ),

          // proceed to payout button
          CustomButton(
            title: "Purchase",
            function: () {
              selectedIndex == -1 ? null : purchaseTicket();
            },
            isInactive: selectedIndex == -1 ? true : false,
          ),
        ],
      ),
    );
  }

  void purchaseTicket() {
    var ticketProvider = Provider.of<TicketProvider>(context, listen: false);
    var event = widget.event;

    Ticket ticket = Ticket(
      price: selectedPrice,
      status: true,
      eventId: event.id,
      category: selectedCatgeory,
      ticketId: "${event.id}1",
    );

    ticketProvider.addTicket(ticket);

    showPurchaseStatus(ticket);
  }

  void showPurchaseStatus(Ticket ticket) {
    showDialog(
      context: context,
      builder: (ctx) => PurchaseStatusWidget(
        selectedCatgeory: selectedCatgeory,
        widget: widget,
        ticket: ticket,
      ),
    );
  }
}
