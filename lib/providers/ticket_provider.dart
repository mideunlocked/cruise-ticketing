import 'package:flutter/widgets.dart';

import '../models/ticket.dart';

class TicketProvider with ChangeNotifier {
  List<Ticket> _tickets = [];

  List<Ticket> get tickets {
    return [..._tickets];
  }

  void addTicket(Ticket ticket) {
    _tickets.add(ticket);
  }
}
