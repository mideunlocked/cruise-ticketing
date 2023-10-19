import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BubbleActionTile extends StatelessWidget {
  const BubbleActionTile({
    super.key,
    required this.title,
    this.icon,
    required this.function,
    this.withIcon = true,
  });

  final String title;
  final bool withIcon;
  final IconData? icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          fontSize: 10.sp,
        ),
      ),
      trailing: withIcon
          ? Icon(
              icon,
              color: Colors.black,
            )
          : null,
      onTap: () => function(),
    );
  }
}
