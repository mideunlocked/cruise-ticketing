import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';
import '../../screens/event_screens/analysis_screen.dart';
import '../../screens/event_screens/scan_ticket_screen.dart';
import '../general_widgets/custom_floating_action_button.dart';

class HostEventActionButton extends StatelessWidget {
  const HostEventActionButton({
    super.key,
    required this.pricing,
  });

  final dynamic pricing;

  @override
  Widget build(BuildContext context) {
    dynamic demoPricing = [
      {"category": "Regular", "price": "NGN 10000", "quantity": "100"},
      {"category": "VIP", "price": "NGN 25000", "quantity": "100"},
      {"category": "VVIP", "price": "NGN 50000", "quantity": "50"},
      {"category": "Table for 10", "price": "NGN 200000", "quantity": "50"},
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomFloatingActionButton(
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => AnalysisScreen(
                  pricing: demoPricing,
                  data: demo,
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
