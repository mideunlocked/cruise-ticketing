import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileTabContainer extends StatelessWidget {
  const ProfileTabContainer({
    super.key,
    required this.title,
    required this.isActive,
    required this.toggleTab,
    required this.borderColor,
  });

  final String title;
  final Color borderColor;
  final bool isActive;
  final Function toggleTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toggleTab();
      },
      splashColor: Colors.transparent,
      child: Container(
        width: 50.w,
        height: 8.h,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: isActive == true ? 4.0 : 1.0,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}
