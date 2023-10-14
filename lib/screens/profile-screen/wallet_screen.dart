import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../models/transactions.dart';
import '../../models/wallet.dart';
import '../../providers/wallet_provider.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/wallet_widgets/balance_and_withdraw_widget.dart';
import '../../widgets/wallet_widgets/transactions_tile.dart';

class WalletScreen extends StatefulWidget {
  static const routeName = "/WalletScreen";

  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isVisible = false;

  void getVisibilty(bool newVisible) {
    setState(() {
      isVisible = newVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context, listen: false);
    Wallet wallet = walletProvider.wallet;
    List<Transaction> transactions = wallet.transactions;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: CustomAppBar(
                title: "Wallet",
                bottomPadding: 2.h,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BalanceAndWithdrawWidget(
                      isVisible: isVisible,
                      walletBalance: wallet.balanceString(),
                      getFunction: getVisibilty,
                    ),
                    const Divider(thickness: 1),
                    transactions.isEmpty
                        ? const EmptyTransaction()
                        : GroupedListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            elements: transactions,
                            order: GroupedListOrder.DESC,
                            groupBy: (element) => DateTime(
                              element.timestamp.year,
                              element.timestamp.month,
                              element.timestamp.day,
                            ),
                            groupSeparatorBuilder: (value) =>
                                TransactionListSeperator(dateTime: value),
                            itemBuilder: (ctx, transaction) {
                              bool isInput = transaction.inputOutput == 1;

                              return TransactionsTile(
                                isDeposit: isInput,
                                isVisible: isVisible,
                                amount: transaction.amountString(),
                                timestamp: transaction.timestamp,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionListSeperator extends StatelessWidget {
  const TransactionListSeperator({
    super.key,
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
      child: Text(
        dateTime.day == DateTime.now().day
            ? "Today"
            : DateTimeFormatting.formatDateTime(dateTime),
      ),
    );
  }
}

class EmptyTransaction extends StatelessWidget {
  const EmptyTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          LottieBuilder.asset(
            "assets/lottie/No_transaction.json",
            height: 40.h,
            width: 80.w,
          ),
          Text(
            "No transaction to see yet.",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const Text(
            "Unlock a detailed view of your transactions by receiving or withdrawing funds. Your financial activity, at a glance, awaits your next transaction.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
