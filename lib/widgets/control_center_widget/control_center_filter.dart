import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'control_center_filter_container.dart';

class ControlCenterFilter extends StatelessWidget {
  const ControlCenterFilter({
    super.key,
    required this.filterIndex,
    required this.changeFilter,
  });

  final Function(int) changeFilter;
  final int filterIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ControlCenterFilterContainer(
            currentIndex: filterIndex,
            index: 0,
            text: "Attendees",
            changeFilter: changeFilter,
          ),
          ControlCenterFilterContainer(
            currentIndex: filterIndex,
            index: 1,
            text: "Verified",
            changeFilter: changeFilter,
          ),
          ControlCenterFilterContainer(
            currentIndex: filterIndex,
            index: 2,
            text: "Unverified",
            changeFilter: changeFilter,
          ),
        ],
      ),
    );
  }
}
