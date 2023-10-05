import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class CenterFocusWidget extends StatelessWidget {
  const CenterFocusWidget({
    super.key,
    required this.googleMapController,
    required this.currentLocation,
  });

  final GoogleMapController? googleMapController;
  final LatLng currentLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 87.h,
        left: 88.w,
      ),
      child: SizedBox(
        height: 8.h,
        width: 8.w,
        child: InkWell(
          onTap: () => googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: currentLocation,
                zoom: 14.0,
              ),
            ),
          ),
          child: Image.asset(
            "assets/icons/focus.png",
            height: 8.h,
            width: 8.w,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
