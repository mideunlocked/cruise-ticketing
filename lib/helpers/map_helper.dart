import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHelper {
  static CameraPosition getInitialCameraLocation() {
    const initialCameraPosition = CameraPosition(
      target: LatLng(
        6.508699130785411,
        3.3217148957424243,
      ),
      zoom: 14,
    );

    return initialCameraPosition;
  }
}
