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
    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return GestureDetector(
      onTap: () => changePage(index, context),
      child: Image.asset(
        iconUrl,
        color: currentIndex == index
            ? checkMode
                ? primaryColor2
                : primaryColor2
            : checkMode
                ? Colors.grey
                : Colors.white,
        height: 5.h,
        width: 5.h,
      ),
    );
  }

  // function to change page in bottom nav
  void changePage(int index, context) {
    pageController.jumpToPage(index);
  }
}
