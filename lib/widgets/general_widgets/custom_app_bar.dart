import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleLarge = textTheme.titleMedium;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // app bar title
                Text(
                  title,
                  style: titleLarge,
                ),
              ],
            ),
          ),

          // custom back button
          const CustomBackButton(),
        ],
      ),
    );
  }
}
