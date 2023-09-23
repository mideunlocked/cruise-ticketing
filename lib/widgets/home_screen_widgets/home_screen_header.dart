import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'home_screen_padding.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
    required this.title,
    required this.screen,
  });

  final String title; // home screen category header
  final Widget screen; // see all screen holder

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return HomeScreenPadding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // home screen category title text widget
          Text(
            title,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),

          // see all text button
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => screen,
              ),
            ),
            child: Text(
              "See All",
              style: of.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
