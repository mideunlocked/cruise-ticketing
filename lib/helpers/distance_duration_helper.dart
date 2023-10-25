import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directions_repo.dart';

class DistanceAndDuration {
  // function to get user current location and calculating the
  //distance between current location and destination (event location)
  // collecting event LatLng
  static Future<dynamic> getDistanceDuration(lat, lng) async {
    LatLng? currentPosition;
    // request persmission if null and get user current location
    await Geolocator.getCurrentPosition().then((value) {
      double lat = value.latitude;
      double lng = value.longitude;
      LatLng valueLatLng = LatLng(lat, lng);

      currentPosition = valueLatLng;
    });

    // retieving and passing event
    //Lat and Lng and decalring it to a variable destination
    final destination = LatLng(
      lat,
      lng,
    );

    // passed the current location coordinates and destiantion coordinates
    //to get the distance and duration of event from current location and then
    //passing it to duration data
    return await DirectionsRepo().getDuration(
        origin: currentPosition ?? const LatLng(0, 0),
        destination: destination);
  }
}
