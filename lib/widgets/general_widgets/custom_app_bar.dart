import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.bottomPadding,
  });

  final String title;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var titleLarge = textTheme.titleMedium;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // custom back button
                CustomBackButton(),
              ],
            ),
          ),
// app bar title
          Text(
            title,
            style: titleLarge,
          ),
        ],
      ),
    );
  }
}
