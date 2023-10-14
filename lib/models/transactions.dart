import '../helpers/format_number.dart';

class Transaction {
  final String id;
  final String from;
  final double amount;
  final int inputOutput;
  final DateTime timestamp;
  final String description;

  const Transaction({
    required this.id,
    required this.from,
    required this.amount,
    required this.timestamp,
    required this.inputOutput,
    required this.description,
  });

  String amountString() {
    String formatedBalance;

    formatedBalance = FormatNumber.addCommas(amount);

    return formatedBalance;
  }
}
