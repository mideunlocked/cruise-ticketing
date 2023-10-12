import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/event_provider.dart';
import 'near_by_tile.dart';

class NearByWidget extends StatelessWidget {
  const NearByWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return SizedBox(
      height: 28.h,
      width: 100.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        // event data iterate through with map
        children: eventProvider.events.map((e) {
          return NearByTile(
            event: e,
          );
        }).toList(),
      ),
    );
  }
}
