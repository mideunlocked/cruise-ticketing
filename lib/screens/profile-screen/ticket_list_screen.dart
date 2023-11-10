import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/ticket_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/empty_list_widget.dart';
import '../../widgets/ticket_widgets/ticket_list_tile.dart';

class TicketListScreen extends StatelessWidget {
  static const routeName = "/TicketListScreen";

  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Ticktes"),
      body: ticketProvider.tickets.isEmpty
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
    );
  }
}
