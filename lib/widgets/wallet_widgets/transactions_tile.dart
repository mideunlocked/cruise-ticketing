import 'package:cruise/helpers/date_time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TransactionsTile extends StatelessWidget {
  const TransactionsTile({
    super.key,
    required this.isVisible,
    required this.amount,
    required this.isDeposit,
    required this.timestamp,
  });

  final DateTime timestamp;
  final bool isVisible;
  final String amount;
  final bool isDeposit;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    var time = DateTimeFormatting.formatedTime(timestamp);
    String sign = isDeposit ? "+" : "-";

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
      subtitle: Text(time),
      trailing: Text(
        !isVisible ? "" : sign + amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDeposit ? Colors.green : null,
          fontSize: 10.sp,
          fontFamily: "Poppins",
        ),
      ),
      shape: const Border(
        bottom: BorderSide(color: Colors.black12),
      ),
    );
  }
}
