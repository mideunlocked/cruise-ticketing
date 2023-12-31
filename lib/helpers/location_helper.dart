import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class LocationHelper {
  static Future<void> requestPermission() async {
    // check is location is enabled on the device
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return;
      }
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
  }

  static Future<BitmapDescriptor> setCustomMarker() async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(7.w, 7.w)), "assets/icons/pin.png");

    return icon;
  }

  static Future<LatLng> getLatLngFromAddress(String address) async {
    List<Location> location =
        await GeocodingPlatform.instance.locationFromAddress(address);

    double lat = location.first.latitude;
    double lng = location.first.longitude;

    return LatLng(lat, lng);
  }
}
