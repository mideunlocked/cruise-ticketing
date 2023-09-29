import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'tab_widget.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
      required this.toggleTab,
      required this.isAbout,
      required this.isDetails});

  final Function toggleTab;
  final bool isAbout, isDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      height: 6.h,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300], // changes UI acccording to device theme mode
      ),
      child: Row(
        // custome tab widgets
        children: [
          // about tab
          TabWidget(
            title: "About",
            check: isAbout,
            toggleTab: () => toggleTab(),
          ),

          // details tab
          TabWidget(
            title: "Details",
            check: isDetails,
            toggleTab: () => toggleTab(),
          ),
        ],
      ),
    );
  }
}
