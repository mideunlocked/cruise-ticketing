import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/event_provider.dart';
import 'rec_event_tile.dart';

class RecomndedWidget extends StatelessWidget {
  const RecomndedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return SizedBox(
      height: 30.h,
      width: 100.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        // event demo data iteration to retrieve data
        children: eventProvider.events.map((e) {
          // rectangular shaped even tile
          return RecEventTile(
            event: e,
          );
        }).toList(),
      ),
    );
  }
}
