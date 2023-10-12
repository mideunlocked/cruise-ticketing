import 'package:cruise/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/ticket.dart';
import '../general_widgets/custom_button.dart';
import 'ticket_pricing_dialog.dart';

class PurchaseStatusWidget extends StatelessWidget {
  const PurchaseStatusWidget({
    super.key,
    required this.selectedCatgeory,
    required this.widget,
    required this.ticket,
  });

  final Ticket ticket;
  final String selectedCatgeory;
  final TicketPricingDialog widget;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var sizedBoxH5 = SizedBox(
      height: 5.h,
    );
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 10.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/check.png",
            ),
            sizedBoxH5,
            Text(
              "Congratulations!",
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              """You've successfully acquired a ticket for $selectedCatgeory to attend ${widget.event.name}. 
Enjoy the event!""",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomButton(
              title: "View ticket",
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => TicketScreen(
                      ticket: ticket,
                      fromPurchase: true,
                    ),
                  ),
                );
              },
            ),
            CustomButton(
              title: "Cancel",
              function: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              isInactive: true,
            ),
          ],
        ),
      ),
    );
  }
}
