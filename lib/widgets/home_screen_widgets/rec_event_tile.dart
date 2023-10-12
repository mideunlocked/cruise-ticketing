import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/directions_repo.dart';
import '../../models/event.dart';
import '../../providers/event_provider.dart';
import '../../screens/event_screens/event_screen.dart';
import '../general_widgets/custom_image_error_widget.dart';
import '../general_widgets/custom_loading_indicator.dart';
import '../general_widgets/save_event_button.dart';
import 'rec_event_tile_overlay.dart';

class RecEventTile extends StatefulWidget {
  const RecEventTile({
    super.key,
    required this.event,
    this.fromSave = false,
  });

  final Event event;
  final bool fromSave;

  @override
  State<RecEventTile> createState() => _RecEventTileState();
}

class _RecEventTileState extends State<RecEventTile> {
  Map<String, dynamic>? durationData; // should hold duration data

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

// var holding passed data from parent
    final passedData = widget.event;
    final lat = passedData.latlng["lat"];
    final lng = passedData.latlng["lng"];

    // calling function to get distance and duration
    await getDistanceDuration(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = 28.h;

    final eventProvider = Provider.of<EventProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 4.w,
        right: widget.fromSave == true ? 4.w : 0,
        bottom: widget.fromSave == true ? 2.h : 0,
      ),
      child: SizedBox(
        height: 28.h,
        width: widget.fromSave == true ? 100.w : 85.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // event image widget
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.event.imageUrl,
                  fit: BoxFit.cover,
                  height: imageHeight,
                  width: widget.fromSave == true ? 100.w : 85.w,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CustomLoadingIndicator(
                      height: imageHeight,
                      width: null,
                    );
                  },
                  errorBuilder: (ctx, _, stacktrace) {
                    return const CustomImageErrorWidget();
                  },
                ),
              ),

              // tile overlay adding a shaded overlay to the bottom of image
              //also holds the even name, date and time
              InkWell(
                // navigate to event screen on tap
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => EventScreen(
                      durationData: durationData ?? {},
                      event: widget.event,
                    ),
                  ),
                ),
                child: RecEventTileOverlay(
                  event: widget.event,
                ),
              ),

              // save event button
              SaveEventButton(
                eventId: widget.event.id,
                isSaved: eventProvider.savedEvents.contains(
                  widget.event.id,
                ),
                top: 1.h,
                left: widget.fromSave == true ? 78.w : 70.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // function to get user current location and calculating the
  //distance between current location and destination (event location)
  // collecting event LatLng
  Future<dynamic> getDistanceDuration(lat, lng) async {
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
    durationData = await DirectionsRepo().getDuration(
        origin: currentPosition ?? const LatLng(0, 0),
        destination: destination);
  }
}
