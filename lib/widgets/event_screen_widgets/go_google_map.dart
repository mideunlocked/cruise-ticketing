import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class GoToGoogleMapIcon extends StatelessWidget {
  const GoToGoogleMapIcon({
    super.key,
    required this.latlng,
  });

  final Map<String, dynamic> latlng;

  @override
  Widget build(BuildContext context) {
    double lat = latlng["lat"];
    double lng = latlng["lng"];

    return InkWell(
      onTap: () async {
        final url = Uri.parse(
            'https://www.google.com/maps/search/?api=1&query=$lat,$lng');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw "Could not launch $url";
        }
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 10.h,
        width: 18.w,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, // makes container circular
            color: Colors.black87 // changes UI acccording to device theme mode
            ),
        alignment: Alignment.center,
        child: const Icon(
          // map icon
          Icons.map_rounded,
          color: Colors.white, // changes UI acccording to device theme mode
        ),
      ),
    );
  }
}
