import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PricingWidget extends StatelessWidget {
  const PricingWidget({
    super.key,
    required this.e,
    required this.index,
    required this.selectedIndex,
  });

  final dynamic e;
  final int index, selectedIndex;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    bool isSelected = selectedIndex == index || selectedIndex == -1;

    return Container(
      height: 8.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        vertical: 1.h,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
        horizontal: 4.w,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // category title text
          Text(
            e["category"] ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.0,
              color: isSelected
                  ? null
                  : bodyMedium?.color?.withOpacity(
                      0.4), // checks if this category is selected and assigns color values to show it
            ),
          ),

          // category ticket price text
          Text(
            e["price"] ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
              color: isSelected
                  ? primaryColor
                  : primaryColor.withOpacity(
                      0.4), // checks if this category is selected and assigns color values to show it
            ),
          ),
        ],
      ),
    );
  }
}
