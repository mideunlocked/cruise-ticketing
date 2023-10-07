import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              BalanceAndWithdrawWidget(
                isVisible: isVisible,
                walletBalance: "100,000.00",
                getFunction: getVisibilty,
              ),
              const Divider(thickness: 1),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    bool isEven = index.isEven;

                    return TransactionsTile(
                      isDeposit: isEven,
                      isVisible: isVisible,
                      amount: isEven ? "+10,000.00" : "-5000.00",
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
