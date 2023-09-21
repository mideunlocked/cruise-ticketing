import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/directions.dart';
import 'env.dart';

class DirectionsRepo {
  static const String googleBaseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";

  late final Dio? _dio;

  DirectionsRepo({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio?.get(googleBaseUrl, queryParameters: {
      'origin': "${origin.latitude},${origin.longitude}",
      'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKey,
    });

    // check is response is successful
    if (response?.statusCode == 200) {
      return Directions.fromMap(response?.data);
    }
    return null;
  }

  Future<String?> getDuration({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio?.get(googleBaseUrl, queryParameters: {
      'origin': "${origin.latitude},${origin.longitude}",
      'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKey,
    });

    // check is response is successful
    if (response?.statusCode == 200) {
      String duration = "";
      var data = response?.data;
      var routes = data["routes"][0];
      if ((routes['legs'] as List).isNotEmpty) {
        final leg = routes["legs"][0] ?? [];
        duration = leg["duration"]["text"] ?? "";
        print("Duration is $duration");
        return duration;
      }
    }
    return null;
  }
}
