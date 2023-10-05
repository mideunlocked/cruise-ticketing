import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TicketCutWidget extends StatelessWidget {
  const TicketCutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // theme data
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ticket cut container
        cutContainer(of),

        // ticket cut line widget
        SizedBox(
          width: 58.w,
          height: 3.0,
          child: ListView.builder(
            itemCount: 58.w ~/ 5.w,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) => Container(
              width: 4.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        // ticket cut container
        cutContainer(of),
      ],
    );
  }

  // ticket cut container method
  Container cutContainer(ThemeData of) {
    return Container(
      height: 12.h,
      width: 18.w,
      decoration: BoxDecoration(
        color: of.scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
