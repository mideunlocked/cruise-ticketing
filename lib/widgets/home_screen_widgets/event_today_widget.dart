import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/event_provider.dart';
import 'event_today_tile.dart';
import 'home_screen_padding.dart';

class EventTodayWidget extends StatelessWidget {
  const EventTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return HomeScreenPadding(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: eventProvider.events // list of events
            .map(
              (e) => EventListTile(event: e), // event today tile
            )
            .toList(),
      ),
    );
  }
}
