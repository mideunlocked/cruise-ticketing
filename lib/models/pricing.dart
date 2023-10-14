class Pricing {
  final int id;
  late double price;
  late int quantity;
  final int quantityLeft;
  late String category;

  Pricing({
    required this.id,
    required this.price,
    required this.category,
    required this.quantity,
    required this.quantityLeft,
  });

  bool isSoldOut() {
    if (quantityLeft == 0) {
      return true;
    }
    return false;
  }
}
