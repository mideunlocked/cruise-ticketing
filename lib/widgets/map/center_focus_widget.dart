import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/map_helper.dart';

class CenterFocusWidget extends StatelessWidget {
  const CenterFocusWidget({
    super.key,
    required this.googleMapController,
  });

  final GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 87.h,
        left: 90.w,
      ),
      child: SizedBox(
        height: 10.h,
        width: 10.w,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () => googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(
                GoogleMapHelper.getInitialCameraLocation()),
          ),
          child: Image.asset(
            "assets/icons/focus.png",
            height: 8.h,
            width: 8.w,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
