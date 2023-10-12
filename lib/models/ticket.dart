class Ticket {
  final String ticketId;
  final String category;
  final String eventId;
  final String price;
  final bool status;

  const Ticket({
    required this.price,
    required this.status,
    required this.eventId,
    required this.category,
    required this.ticketId,
  });
}
