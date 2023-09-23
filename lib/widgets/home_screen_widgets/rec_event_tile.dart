import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/directions_repo.dart';
import '../../helpers/location_helper.dart';
import '../../screens/event_screen.dart';
import '../general_widgets/save_event_button.dart';
import 'rec_event_tile_overlay.dart';

class RecEventTile extends StatefulWidget {
  const RecEventTile({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<RecEventTile> createState() => _RecEventTileState();
}

class _RecEventTileState extends State<RecEventTile> {
  Map<String, dynamic>? durationData; // should hold duration data

  @override
  void initState() {
    super.initState();

    // var holding passed data from parent
    final passedData = widget.data;

    // calling function to get distance and duration
    getDistanceDuration(passedData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.w,
      ),
      child: InkWell(
        // navigate to event screen on tap
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => EventScreen(
              durationData: durationData ?? {},
              eventData: widget.data,
            ),
          ),
        ),

        // rec tile widget
        child: SizedBox(
          height: 28.h,
          width: 85.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                // event image widget
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.data["imageUrl"] ?? "",
                    fit: BoxFit.cover,
                    height: 28.h,
                    width: 85.w,
                  ),
                ),

                // save event button
                const SaveEventButton(),

                // tile overlay adding a shaded overlay to the bottom of image
                //also holds the even name, date and time
                RecEventTileOverlay(
                  data: widget.data,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // function to get user current location and calculating the
  //distance between current location and destination (event location)
  // collecting event LatLng
  Future<dynamic> getDistanceDuration(dynamic passedData) async {
    // request persmission if null and get user current location
    final response = await LocationHelper.requestPermission();

    // pass current location as latitude and longitude
    final currentPosition = LatLng(
      response.latitude,
      response.longitude,
    );

    // retieving and passing event
    //Lat and Lng and decalring it to a variable destination
    final destination = LatLng(
      passedData["lat"],
      passedData["lng"],
    );

    // passed the current location coordinates and destiantion coordinates
    //to get the distance and duration of event from current location and then
    //passing it to duration data
    durationData = await DirectionsRepo()
        .getDuration(origin: currentPosition, destination: destination);
  }
}
