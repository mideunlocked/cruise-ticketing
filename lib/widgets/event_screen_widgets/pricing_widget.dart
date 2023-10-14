import 'package:cruise/models/pricing.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class PricingWidget extends StatelessWidget {
  const PricingWidget({
    super.key,
    required this.price,
    required this.index,
    required this.selectedIndex,
  });

  final Pricing price;
  final int index, selectedIndex;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    bool isSelected = selectedIndex == index || selectedIndex == -1;
    bool isSoldOut = price.isSoldOut();

    return Container(
      height: 8.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        vertical: 1.h,
      ),
      padding: EdgeInsets.symmetric(
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
            price.category,
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

          Visibility(
            visible: isSoldOut,
            child: LottieBuilder.asset(
              "assets/lottie/sold_out.json",
              height: 10.h,
              width: 15.w,
              fit: BoxFit.cover,
            ),
          ),

          // category ticket price text
          Text(
            price.price.toString(),
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
