import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/event_provider.dart';
import '../widgets/general_widgets/custom_app_bar.dart';
import '../widgets/ticket_widgets/event_detail_box.dart';
import '../widgets/ticket_widgets/qr_code_widget.dart';
import '../widgets/ticket_widgets/ticket_cut_widget.dart';
import '../widgets/ticket_widgets/ticket_widget_padding.dart';

class TicketScreen extends StatelessWidget {
  static const routeName = "/TicketScreen";

  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // theme data
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // some space
            SizedBox(
              height: 1.h,
            ),

            // custom app bar
            TicketWidgetPadding(
              horizontalPadding: 3.w,
              child: CustomAppBar(
                title: "My Ticket",
                bottomPadding: 2.h,
              ),
            ),

            // ticket widget
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        TicketWidgetPadding(
                          horizontalPadding: 8.w,
                          child: Container(
                            height: 80.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: primaryColor, width: 2.0),
                              color: primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // qr code widget box (qr code and instruction)
                                const QrCodeWidget(),

                                // ticket event details (name, date, time, venue, category, price)
                                EventDetailBox(
                                  event: eventProvider.events.first,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ticket cut widget
                        const TicketCutWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
