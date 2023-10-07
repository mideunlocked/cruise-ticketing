import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/general_widgets/custom_app_bar.dart';

class WalletScreen extends StatefulWidget {
  static const routeName = "/WalletScreen";

  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    String invisible = "XXXXX";
    String balance = "100,000.00";

    String walletBalance = !isVisible ? invisible : balance;

    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
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
                          "NGN $walletBalance",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() => isVisible = !isVisible);
                          },
                          icon: Icon(
                            isVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                            color: !isVisible ? Colors.grey : primaryColor,
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
              ),
              const Divider(thickness: 1),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    bool isEven = index.isEven;
                    var textTheme = of.textTheme;
                    var bodyMedium = textTheme.bodyMedium;

                    return ListTile(
                      minVerticalPadding: 2.h,
                      leading: CircleAvatar(
                        backgroundColor: isEven ? Colors.green : Colors.red,
                        child: Icon(
                          isEven ? Icons.add_rounded : Icons.remove_rounded,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        isEven ? "Input Transaction" : "Output Transaction",
                        style: bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text("5:42 PM"),
                      trailing: Text(
                        !isVisible
                            ? ""
                            : isEven
                                ? "+10,000.00"
                                : "-5000.00",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isEven ? Colors.green : null,
                        ),
                      ),
                      shape: const Border(
                        bottom: BorderSide(color: Colors.black12),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
