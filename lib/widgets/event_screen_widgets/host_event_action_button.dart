import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event.dart';
import '../../screens/event_screens/analysis_screen.dart';
import '../../screens/event_screens/scan_ticket_screen.dart';
import '../general_widgets/custom_floating_action_button.dart';

class HostEventActionButton extends StatelessWidget {
  const HostEventActionButton({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomFloatingActionButton(
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => AnalysisScreen(
                  pricing: event.pricing,
                  data: event.analysis,
                ),
              ),
            );
          },
          heroTag: "Event Analytics",
          iconUrl: "data-analysis",
        ),
        SizedBox(
          height: 2.h,
        ),
        CustomFloatingActionButton(
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const ScanEventScreen(),
              ),
            );
          },
          heroTag: "Start Event",
          iconUrl: "play",
        ),
      ],
    );
  }
}
