import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';
import 'rec_event_tile.dart';

class RecomndedWidget extends StatelessWidget {
  const RecomndedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 100.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        // event demo data iteration to retrieve data
        children: event.map((e) {
          // rectangular shaped even tile
          return RecEventTile(
            data: e,
          );
        }).toList(),
      ),
    );
  }
}
