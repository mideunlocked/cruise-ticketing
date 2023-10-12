import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/ticket_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/empty_list_widget.dart';
import '../../widgets/home_screen_widgets/home_screen_padding.dart';
import '../../widgets/ticket_widgets/ticket_list_tile.dart';

class TicketListScreen extends StatelessWidget {
  static const routeName = "/TicketListScreen";

  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 1.h,
    );

    var ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            sizedBox,
            const HomeScreenPadding(
              child: CustomAppBar(
                title: "Tickets",
                bottomPadding: 0,
              ),
            ),
            const Divider(
              color: Colors.black12,
            ),
            Expanded(
              child: ticketProvider.tickets.isEmpty
                  ? const EmptyListWidget(
                      title: "No tickets available",
                      subTitle: "Explore more and start adding tickets!",
                    )
                  : ListView(
                      children: ticketProvider.tickets
                          .map(
                            (e) => TicketListTile(
                              ticket: e,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
