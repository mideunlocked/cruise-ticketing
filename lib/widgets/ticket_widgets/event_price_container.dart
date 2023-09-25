import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EventPriceContainer extends StatelessWidget {
  const EventPriceContainer({
    super.key,
    required this.detailTileEdgeInsets,
    required this.data,
  });

  // ticket screen detail tile edgeinsets
  final EdgeInsets detailTileEdgeInsets;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    // theme data
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Container(
      height: 5.h,
      width: 100.w,
      color: primaryColor.withOpacity(0.2),
      margin: EdgeInsets.only(top: 3.h),
      padding: detailTileEdgeInsets,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ticket category text
          Text(data["pricing"][1]["category"] ?? ""),

          // ticket price text
          Text(
            data["pricing"][1]["price"] ?? "",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
