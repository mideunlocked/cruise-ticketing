import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ControlCenterFilterContainer extends StatelessWidget {
  const ControlCenterFilterContainer({
    super.key,
    required this.currentIndex,
    required this.text,
    required this.index,
    required this.changeFilter,
  });

  final Function(int) changeFilter;
  final int currentIndex;
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool isCurrent = currentIndex == index;

    return InkWell(
      onTap: () {
        changeFilter(index);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        margin: EdgeInsets.only(
            left: index == 0 ? 3.w : 0, right: 2.w, bottom: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCurrent ? Colors.black : Colors.grey[200],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isCurrent ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
