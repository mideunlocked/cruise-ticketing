import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../general_widgets/custom_app_bar.dart';

// ignore: must_be_immutable
class BalanceAndWithdrawWidget extends StatefulWidget {
  BalanceAndWithdrawWidget({
    super.key,
    required this.isVisible,
    required this.walletBalance,
    required this.getFunction,
  });

  bool isVisible;
  final String walletBalance;
  final Function(bool) getFunction;

  @override
  State<BalanceAndWithdrawWidget> createState() =>
      _BalanceAndWithdrawWidgetState();
}

class _BalanceAndWithdrawWidgetState extends State<BalanceAndWithdrawWidget> {
  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    String invisible = "XXXXX";

    String balance = !widget.isVisible ? invisible : widget.walletBalance;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            title: "Wallet",
            bottomPadding: 2.h,
          ),
          const Text(
            "🇳🇬 Nigerian Naira",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "NGN $balance",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() => widget.isVisible = !widget.isVisible);
                  widget.getFunction(widget.isVisible);
                },
                icon: Icon(
                  widget.isVisible
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: !widget.isVisible ? Colors.grey : primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Last updated few seconds ago",
            style: TextStyle(
              fontSize: 8.sp,
              color: Colors.black38,
            ),
          ),
          SizedBox(height: 1.h),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(primaryColor),
            ),
            onPressed: () {},
            child: const Text("Withdraw"),
          ),
        ],
      ),
    );
  }

  void showPayoutDialog() {}
}
