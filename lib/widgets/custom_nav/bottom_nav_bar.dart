import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_nav.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  final PageController pageController;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(40);
    const borderRadius = BorderRadius.only(
      topLeft: radius,
      topRight: radius,
    );

    return Material(
      elevation: 30.0,
      borderRadius: borderRadius,
      color: Colors.transparent,
      child: Container(
        height: 9.h,
        width: 100.w,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 1, 29),
          borderRadius: borderRadius,
        ),
        child: CustomBottomNav(
          pageController: pageController,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
