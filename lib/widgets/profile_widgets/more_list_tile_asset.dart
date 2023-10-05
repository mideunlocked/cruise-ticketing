import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MoreListTileAsset extends StatelessWidget {
  const MoreListTileAsset({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.function,
  });

  final String iconUrl;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

    bool isSignOut = title.contains("out");

    return ListTile(
      horizontalTitleGap: 1.w,
      leading: Image.asset(
        "assets/icons/$iconUrl.png",
        color: isSignOut ? Colors.red : color,
        height: 6.h,
        width: 6.w,
      ),
      title: Text(
        title,
        style: bodyMedium?.copyWith(
          color: isSignOut ? Colors.red : null,
        ),
      ),
      onTap: () {
        function();
      },
    );
  }
}
