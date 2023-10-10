class EventAnalysis {
  final int ticketSold;
  final int totalViews;
  final int attendance;
  final int ticketQuantity;
  final List<Map<String, dynamic>> ages;
  final List<Map<String, dynamic>> genders;
  final List<Map<String, dynamic>> deviceSales;
  final List<Map<String, dynamic>> attendeeLocations;
  final List<Map<String, dynamic>> soldTicketBreakdown;

  const EventAnalysis({
    required this.ages,
    required this.genders,
    required this.ticketSold,
    required this.totalViews,
    required this.attendance,
    required this.deviceSales,
    required this.ticketQuantity,
    required this.attendeeLocations,
    required this.soldTicketBreakdown,
  });

  double getPriceFromString(String pricing) {
    String stringPrice = pricing.toString();
    List getPriceDouble = stringPrice.split(" ");
    double priceDouble = double.parse(getPriceDouble.last);

    return priceDouble;
  }

  double getEstimatedRevenue(List<Map<String, dynamic>> pricing) {
    double estimatedRevenue = 0;
    dynamic prices;

    for (prices in pricing) {
      double priceDouble = getPriceFromString(prices["price"]);
      double quantity = double.parse(prices["quantity"]);
      double ticketTypeEstimate = quantity * priceDouble;

      estimatedRevenue = estimatedRevenue + ticketTypeEstimate;
    }

    return estimatedRevenue;
  }

  List<dynamic> calculateTypeRevenue(List<Map<String, dynamic>> pricing) {
    dynamic price;
    List<Map<String, dynamic>> breakDown = [];

    for (price in pricing) {
      dynamic i;

      for (i in soldTicketBreakdown) {
        if (i["type"] == price["category"]) {
          double priceDouble = getPriceFromString(price["price"]);
          double categoryRevenue = priceDouble * i["value"];
          breakDown.add({
            "type": i["type"],
            "value": categoryRevenue,
          });
        }
      }
    }

    return breakDown;
  }

  double getCurrentRevenue(List<Map<String, dynamic>> ticketTypesRevenue) {
    double currentRevenue = 0;
    dynamic i = {};

    for (i in ticketTypesRevenue) {
      currentRevenue = currentRevenue + i["value"];
    }

    return currentRevenue;
  }

  String eventConversion() {
    double conversionPercentage = 0;
    String approximateConversion = "";
    int decimalPlaces = 2;

    conversionPercentage = (ticketSold / ticketQuantity) * 100;
    approximateConversion = conversionPercentage.toStringAsFixed(decimalPlaces);

    return "$approximateConversion%";
  }

  Map<String, dynamic> getMostPopularTicketType() {
    Map<String, dynamic> mostPopular = {};
    int quantity = 0;
    dynamic i;

    for (i in soldTicketBreakdown) {
      if (i["value"] > quantity) {
        quantity = i["value"];
        mostPopular = {
          i["type"]: i["value"],
        };
      }
    }

    return mostPopular;
  }

  double conversionPercentage() {
    double percent = (ticketSold / totalViews) * 100;

    return percent;
  }
}
