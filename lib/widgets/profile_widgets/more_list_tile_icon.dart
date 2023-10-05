import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MoreListTileIcon extends StatelessWidget {
  const MoreListTileIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.function,
  });

  final IconData icon;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var color = bodyMedium?.color;

    return ListTile(
      horizontalTitleGap: 1.w,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: bodyMedium?.copyWith(color: null),
      ),
      onTap: () {
        function();
      },
    );
  }
}
