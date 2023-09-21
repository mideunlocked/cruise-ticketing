import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.bounds,
    required this.totalDistance,
    required this.totalDuration,
    required this.polylinePoints,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    //check if routes is not available
    // if ((map["routes"] as List).isEmpty) return null;

    // Get routes info
    final data = Map<String, dynamic>.from(map["routes"][0]);

    // bounds
    final northeast = data["bounds"]["northeast"];
    final southwest = data["bounds"]["southwest"];
    final bounds = LatLngBounds(
      southwest: LatLng(
        southwest["lat"],
        southwest["lng"],
      ),
      northeast: LatLng(
        northeast["lat"],
        northeast["lng"],
      ),
    );

    //Distance && Duration
    String distance = "";
    String duration = "";
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data["legs"][0];
      distance = leg["distance"]["text"];
      duration = leg["duration"]["text"];
    }

    return Directions(
      bounds: bounds,
      totalDistance: distance,
      totalDuration: duration,
      polylinePoints: PolylinePoints().decodePolyline(
        data["overview_polyline"]["points"],
      ),
    );
  }
}
