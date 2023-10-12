import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/ticket.dart';

class EventPriceContainer extends StatelessWidget {
  const EventPriceContainer({
    super.key,
    required this.detailTileEdgeInsets,
    required this.ticket,
  });

  // ticket screen detail tile edgeinsets
  final EdgeInsets detailTileEdgeInsets;
  final Ticket ticket;

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
          Text(ticket.price),

          // ticket price text
          Text(
            ticket.category,
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
