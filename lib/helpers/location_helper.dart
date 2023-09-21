import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class LocationHelper {
  static Future<Position> requestPermission() async {
    // check is location is enabled on the device
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location services are deisbaled");
    }

    // get location permission status
    LocationPermission permission = await Geolocator.checkPermission();

    // check if permission as been granted
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Future.error(
          "Location perssion are permanetly denied, we cannot request ");
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<BitmapDescriptor> setCustomMarker() async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(7.w, 7.w)), "assets/icons/pin.png");

    return icon;
  }
}
