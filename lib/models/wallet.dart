import '../helpers/format_number.dart';
import 'transactions.dart';

class Wallet {
  final double balance;
  final List<Transaction> transactions;

  const Wallet({
    required this.balance,
    required this.transactions,
  });

  String balanceString() {
    String formatedBalance;

    formatedBalance = FormatNumber.addCommas(balance);

    return formatedBalance;
  }
}
