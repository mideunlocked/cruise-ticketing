import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FollowersFollowingTab extends StatelessWidget {
  const FollowersFollowingTab({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.title,
    required this.controller,
  });

  final int index;
  final int currentIndex;
  final String title;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.jumpToPage(index);
      },
      child: Container(
        width: 50.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: currentIndex == index ? Colors.black87 : Colors.black12,
            ),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
