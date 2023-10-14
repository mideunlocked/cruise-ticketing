import 'package:flutter/material.dart';

import '../models/transactions.dart';
import '../models/wallet.dart';

class WalletProvider with ChangeNotifier {
  final Wallet _wallet = Wallet(
    balance: 100000,
    transactions: [
      Transaction(
        id: "0",
        from: "Event 1",
        amount: 10000,
        timestamp: DateTime(2023, 10, 11, 14, 1),
        inputOutput: 1,
        description: "Payment for event 1",
      ),
      Transaction(
        id: "1",
        from: "Event 1",
        amount: 10000,
        timestamp: DateTime(2023, 10, 12, 14, 2),
        inputOutput: 1,
        description: "Payment for event 1",
      ),
      Transaction(
        id: "2",
        from: "Event 1",
        amount: 10000,
        timestamp: DateTime(2023, 10, 13, 14, 3),
        inputOutput: 1,
        description: "Payment for event 1",
      ),
      Transaction(
        id: "3",
        from: "Event 1",
        amount: 10000,
        timestamp: DateTime(2023, 10, 13, 14, 4),
        inputOutput: 1,
        description: "Payment for event 1",
      ),
      Transaction(
        id: "4",
        from: "Event 1",
        amount: 20000,
        timestamp: DateTime(2023, 10, 13, 14, 4),
        inputOutput: 1,
        description: "Payment for event 1",
      ),
      Transaction(
        id: "5",
        from: "Event 1",
        amount: 20000,
        timestamp: DateTime(2023, 10, 13, 14, 4),
        inputOutput: 1,
        description: "Payment for event 1",
      ),
      Transaction(
        id: "6",
        from: "Event 1",
        amount: 20000,
        timestamp: DateTime.now(),
        inputOutput: 1,
        description: "Payment for event 1",
      ),
      Transaction(
        id: "7",
        from: "My wallet",
        amount: 20000,
        timestamp: DateTime.now(),
        inputOutput: 0,
        description: "Payout 1",
      ),
    ],
  );

  Wallet get wallet {
    return _wallet;
  }
}
