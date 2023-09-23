import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data.dart';
import 'near_by_tile.dart';

class NearByWidget extends StatelessWidget {
  const NearByWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      width: 100.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        // event data iterate through with map
        children: event.map((e) {
          return NearByTile(
            data: e,
          );
        }).toList(),
      ),
    );
  }
}
