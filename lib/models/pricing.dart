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

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      id: json["id"] as int,
      price: double.parse(json["price"].toString()),
      category: json["category"] as String,
      quantity: json["quantity"] as int,
      quantityLeft: json["quantityLeft"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "price": price,
      "category": category,
      "quantity": quantity,
      "quantityLeft": quantityLeft,
    };
  }

  bool isSoldOut() {
    if (quantityLeft == 0) {
      return true;
    }
    return false;
  }
}
