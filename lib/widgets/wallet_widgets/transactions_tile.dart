import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TransactionsTile extends StatelessWidget {
  const TransactionsTile({
    super.key,
    required this.isVisible,
    required this.amount,
    required this.isDeposit,
  });

  final bool isVisible;
  final String amount;
  final bool isDeposit;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    return ListTile(
      minVerticalPadding: 2.h,
      leading: CircleAvatar(
        backgroundColor: isDeposit ? Colors.green : Colors.red,
        child: Icon(
          isDeposit ? Icons.add_rounded : Icons.remove_rounded,
          color: Colors.white,
        ),
      ),
      title: Text(
        isDeposit ? "Input Transaction" : "Output Transaction",
        style: bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: const Text("5:42 PM"),
      trailing: Text(
        !isVisible ? "" : amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDeposit ? Colors.green : null,
          fontSize: 10.sp,
        ),
      ),
      shape: const Border(
        bottom: BorderSide(color: Colors.black12),
      ),
    );
  }
}
