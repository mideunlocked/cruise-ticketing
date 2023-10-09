import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/directions_repo.dart';
import '../../screens/event_screens/event_screen.dart';
import 'event_name_date_widget.dart';

class NearByTile extends StatefulWidget {
  const NearByTile({
    super.key,
    required this.data,
  });

  final dynamic data; // get event data

  @override
  State<NearByTile> createState() => _NearByTileState();
}

class _NearByTileState extends State<NearByTile> {
  Map<String, dynamic>? durationData; // should hold duration data

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // var holding passed data from parent
    final passedData = widget.data;

    // calling function to get distance and duration
    await getDistanceDuration(passedData);
  }

  @override
  Widget build(BuildContext context) {
    // var of = Theme.of(context);
    // var primaryColor = of.primaryColor;

    // check if device is dark mode or light mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          // move to event screen
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => EventScreen(
                  durationData: durationData ?? {}, eventData: widget.data),
            ),
          ),
          child: Container(
            height: 28.h,
            width: 40.w,
            margin: EdgeInsets.only(
              left: 4.w,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                // event image widget
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.network(
                    widget.data["imageUrl"],
                    height: 12.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                ),

                // event detail widget
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // custom widget holding event date, day and name
                      EventNameAndDateWidget(
                        data: widget.data,
                        isStart: true,
                        largeText: false,
                      ),

                      // some space
                      SizedBox(
                        height: 0.5.h,
                      ),

                      // venue text widget
                      Text(
                        widget.data["venue"] ?? "",
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // show walk duration to destination
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Row(
            children: [
              // walk icon
              const Icon(
                Icons.directions_walk_rounded,
                color: Colors.black,
              ),

              // some space
              SizedBox(
                width: 1.w,
              ),

              // walk duration text widget

              // check if duration data passed is empty
              durationData == {}
                  ?
                  // if true its probably loading displaying a progress indicator
                  SizedBox(
                      height: 8.sp,
                      width: 8.sp,
                      child: const CircularProgressIndicator(
                        color: Colors.white30,
                        strokeWidth: 1,
                      ),
                    )
                  : Text(
                      // else it has data display duration text
                      durationData?["duration"] ?? "",
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  // function to get user current location and calculating the
  //distance between current location and destination (event location)
  // collecting event LatLng
  Future<dynamic> getDistanceDuration(dynamic passedData) async {
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
      passedData["lat"],
      passedData["lng"],
    );

    // passed the current location coordinates and destiantion coordinates
    //to get the distance and duration of event from current location and then
    //passing it to duration data
    final directions = await DirectionsRepo().getDuration(
        origin: currentPosition ?? const LatLng(0, 0),
        destination: destination);

    setState(() {
      durationData = directions;
    });
  }
}
