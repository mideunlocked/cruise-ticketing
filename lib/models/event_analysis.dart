import 'package:cruise/models/pricing.dart';

class EventAnalysis {
  final int ticketSold;
  final int totalViews;
  final int attendance;
  final int ticketQuantity;
  final List<dynamic> ages;
  final List<dynamic> genders;
  final List<dynamic> deviceSales;
  final List<dynamic> attendeeLocations;
  final List<dynamic> soldTicketBreakdown;

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

  factory EventAnalysis.fromJson(Map<String, dynamic> json) {
    return EventAnalysis(
      ages: json["ages"] as List<dynamic>,
      genders: json["genders"] as List<dynamic>,
      ticketSold: json["ticketSold"] as int,
      totalViews: json["totalViews"] as int,
      attendance: json["attendance"] as int,
      deviceSales: json["deviceSales"] as List<dynamic>,
      ticketQuantity: json["ticketQuantity"] as int,
      attendeeLocations: json["attendeeLocations"] as List<dynamic>,
      soldTicketBreakdown: json["soldTicketBreakdown"] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ages": ages,
      "genders": genders,
      "ticketSold": ticketSold,
      "totalViews": totalViews,
      "attendance": attendance,
      "deviceSales": deviceSales,
      "ticketQuantity": ticketQuantity,
      "attendeeLocations": attendeeLocations,
      "soldTicketBreakdown": soldTicketBreakdown,
    };
  }

  bool checkSoldOut() {
    if (ticketQuantity == ticketSold) {
      return true;
    }
    return false;
  }

  double getEstimatedRevenue(List<Pricing> pricing) {
    double estimatedRevenue = 0;
    Pricing price;

    for (price in pricing) {
      double quantity = double.parse(price.quantity.toString());
      double ticketTypeEstimate = quantity * price.price;

      estimatedRevenue = estimatedRevenue + ticketTypeEstimate;
    }

    return estimatedRevenue;
  }

  List<dynamic> calculateTypeRevenue(List<Pricing> pricing) {
    Pricing price;
    List<Map<String, dynamic>> breakDown = [];

    for (price in pricing) {
      dynamic i;

      for (i in soldTicketBreakdown) {
        if (i["type"] == price.category) {
          double categoryRevenue = price.price * i["value"];
          breakDown.add({
            "type": i["type"],
            "value": categoryRevenue,
          });
        }
      }
    }

    return breakDown;
  }

  double getCurrentRevenue(List<dynamic> ticketTypesRevenue) {
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
          i["type"].toString(): i["value"],
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
