import 'package:flutter/material.dart';

import 'followers_following_tab.dart';

class FollowersFollowingTabBar extends StatelessWidget {
  const FollowersFollowingTabBar({
    super.key,
    required this.currentIndex,
    required this.controller,
  });

  final int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FollowersFollowingTab(
            index: 0,
            currentIndex: currentIndex,
            title: "Followers",
            controller: controller),
        FollowersFollowingTab(
          index: 1,
          currentIndex: currentIndex,
          title: "Following",
          controller: controller,
        ),
      ],
    );
  }
}
