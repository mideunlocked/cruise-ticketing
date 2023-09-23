import 'package:flutter/material.dart';

import '../../data.dart';
import 'event_today_tile.dart';
import 'home_screen_padding.dart';

class EventTodayWidget extends StatelessWidget {
  const EventTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenPadding(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: event // list of events
            .map(
              (e) => EventTodayTile(data: e), // event today tile
            )
            .toList(),
      ),
    );
  }
}
