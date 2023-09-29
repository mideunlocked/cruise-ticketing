import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'bottom_nav_icon.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  final PageController pageController;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomNavIcon(
            iconUrl: "assets/icons/home.png",
            pageController: pageController,
            index: 0,
            currentIndex: currentIndex,
          ),
          BottomNavIcon(
            iconUrl: "assets/icons/search.png",
            pageController: pageController,
            index: 1,
            currentIndex: currentIndex,
          ),
          BottomNavIcon(
            iconUrl: "assets/icons/placeholder.png",
            pageController: pageController,
            index: 2,
            currentIndex: currentIndex,
          ),
          BottomNavIcon(
            iconUrl: "assets/icons/user.png",
            pageController: pageController,
            index: 3,
            currentIndex: currentIndex,
          ),
        ],
      ),
    );
  }
}
