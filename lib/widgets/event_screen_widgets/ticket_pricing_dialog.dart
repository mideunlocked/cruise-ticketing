import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_button.dart';
import 'pricing_widget.dart';

class TicketPricingDialog extends StatefulWidget {
  const TicketPricingDialog({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<TicketPricingDialog> createState() => _TicketPricingDialogState();
}

class _TicketPricingDialogState extends State<TicketPricingDialog> {
  // holds the selected price index
  var selectedIndex = -1;

  // holds the selected price
  String selectedPrice = "";

  String selectedCatgeory = "";

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    var pricing = widget.data["pricing"];

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
              itemCount: pricing.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  if (selectedIndex == index) {
                    setState(() {
                      selectedIndex = -1;
                      selectedPrice = "";
                      selectedCatgeory = "";
                    });
                  } else {
                    setState(() {
                      selectedIndex = index; // pass currently selected index
                      selectedPrice = pricing[index]
                          ["price"]; // pass currently selected price
                      selectedCatgeory = pricing[index]
                          ["category"]; // pass currently selected category
                    });
                  }
                },

                // category and price widget
                child: PricingWidget(
                  e: pricing[index] ?? {},
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
              selectedIndex == -1 ? null : showPurchaseStatus();
            },
            isInactive: selectedIndex == -1 ? true : false,
          ),
        ],
      ),
    );
  }

  void showPurchaseStatus() {
    showDialog(
      context: context,
      builder: (ctx) => PurchaseStatusWidget(
        selectedCatgeory: selectedCatgeory,
        widget: widget,
      ),
    );
  }
}

class PurchaseStatusWidget extends StatelessWidget {
  const PurchaseStatusWidget({
    super.key,
    required this.selectedCatgeory,
    required this.widget,
  });

  final String selectedCatgeory;
  final TicketPricingDialog widget;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var sizedBoxH5 = SizedBox(
      height: 5.h,
    );
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 10.w,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/check.png",
            ),
            sizedBoxH5,
            Text(
              "Congratulations!",
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              """You've successfully acquired a ticket for $selectedCatgeory to attend ${widget.data["name"]}. 
Enjoy the event!""",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomButton(
              title: "View ticket",
              function: () {
                Navigator.pushNamed(context, "/TicketScreen");
              },
            ),
            CustomButton(
              title: "Cancel",
              function: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              isInactive: true,
            ),
          ],
        ),
      ),
    );
  }
}
