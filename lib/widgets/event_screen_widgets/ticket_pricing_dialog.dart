import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_button.dart';
import 'pricing_widget.dart';

class TicketPricingDialog extends StatefulWidget {
  const TicketPricingDialog({
    super.key,
    required this.pricing,
  });

  final List<dynamic> pricing;

  @override
  State<TicketPricingDialog> createState() => _TicketPricingDialogState();
}

class _TicketPricingDialogState extends State<TicketPricingDialog> {
  // holds the selected price index
  var selectedIndex = -1;

  // holds the selected price
  String selectedPrice = "";

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    return Container(
      height: double.infinity,
      color: scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // some space
          SizedBox(
            height: 2.h,
          ),

          // buy ticket title
          Text(
            "Buy Ticket",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: primaryColor,
              letterSpacing: 2.0,
            ),
          ),

          // some space
          SizedBox(
            height: 1.h,
          ),

          // list of prices and categories
          Expanded(
            child: ListView.builder(
              itemCount: widget.pricing.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index; // pass currently selected index
                    selectedPrice = widget.pricing[index]
                        ["price"]; // pass currently selected price
                  });
                },

                // category and price widget
                child: PricingWidget(
                  e: widget.pricing[index],
                  selectedIndex: selectedIndex,
                  index: index,
                ),
              ),
            ),
          ),

          // proceed to payout button
          CustomButton(
            title: "Purchase",
            function: () {
              var price = selectedPrice.split(" ");
              print(price[1]);
            },
          ),
        ],
      ),
    );
  }
}
