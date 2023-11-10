import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/event_provider.dart';
import '../widgets/home_screen_widgets/event_today_tile.dart';
import '../widgets/general_widgets/custom_app_bar.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    var insetSymmetric = EdgeInsets.symmetric(horizontal: 3.w);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Recommended",
      ),
      body: SafeArea(
        child: Column(
          children: [
            // list of events to see
            Expanded(
                child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: eventProvider.events // list of events
                  .map(
                    (e) => Padding(
                      padding: insetSymmetric,
                      child: EventListTile(event: e),
                    ), // event today tile
                  )
                  .toList(),
            )),
          ],
        ),
      ),
    );
  }
}
