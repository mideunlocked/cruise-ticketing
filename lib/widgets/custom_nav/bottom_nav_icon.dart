import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key,
    required this.iconUrl,
    required this.index,
    required this.pageController,
    required this.currentIndex,
  });

  final String iconUrl;
  final int index;
  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var primaryColor2 = Theme.of(context).primaryColor;
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return IconButton(
      onPressed: () => changePage(index, context),
      icon: Image.asset(
        iconUrl,
        color: currentIndex == index ? primaryColor2 : Colors.grey,
        height: 5.h,
        width: 5.w,
      ),
    );
  }

  // function to change page in bottom nav
  void changePage(int index, context) {
    pageController.jumpToPage(index);
  }
}
