import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'profile_bottom_sheet.dart';
import 'profile_icon_button.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Profile",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        ProfileIconButton(
          iconUrl: "add",
          onPressed: () {
            Navigator.pushNamed(context, "/CreateEventScreen");
          },
          color: color ?? Colors.transparent,
        ),
        ProfileIconButton(
          iconUrl: "more_circular",
          onPressed: () => showMoreBottomSheet(context),
          color: color ?? Colors.transparent,
        ),
      ],
    );
  }

  void showMoreBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (ctx) => const ProfileBottomSheet(),
    );
  }
}
