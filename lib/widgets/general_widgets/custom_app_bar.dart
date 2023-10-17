import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // custom back button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 7.w,
          ),
          // app bar title
          Text(
            title,
            style: titleLarge?.copyWith(
                letterSpacing: 0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
