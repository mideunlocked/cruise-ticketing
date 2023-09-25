import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TicketDetailTile extends StatelessWidget {
  const TicketDetailTile({
    super.key,
    required this.edgeInsets,
    required this.iconUrl,
    required this.text,
  });

  final EdgeInsets edgeInsets;
  final String iconUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    // theme data
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Padding(
      padding: EdgeInsets.only(left: 6.w, right: 2.w),
      child: Row(
        children: [
          // ticket detail custom asset icon
          Image.asset(
            "assets/icons/$iconUrl.png",
            height: 5.h,
            width: 5.w,
            color: primaryColor,
          ),

          // some spacing
          SizedBox(
            width: 3.w,
          ),

          // ticket detail text
          Text(text),
        ],
      ),
    );
  }
}
