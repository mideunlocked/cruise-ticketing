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

  dynamic checkTicket(String eventId) {
    Ticket ticket;

    for (ticket in _tickets) {
      ticket.eventId == eventId;
      return ticket;
    }
    return false;
  }
}
