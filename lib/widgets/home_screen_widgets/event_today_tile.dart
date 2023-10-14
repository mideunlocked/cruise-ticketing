import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/directions_repo.dart';
import '../../models/event.dart';
import '../../models/users.dart';
import '../../providers/users_provider.dart';
import '../../screens/event_screens/event_screen.dart';
import '../general_widgets/custom_image_error_widget.dart';
import '../general_widgets/custom_loading_indicator.dart';
import '../general_widgets/profile_image.dart';

class EventListTile extends StatefulWidget {
  const EventListTile({
    super.key,
    required this.event,
  });

  final Event event; // get event data

  @override
  State<EventListTile> createState() => _EventTodayTileState();
}

class _EventTodayTileState extends State<EventListTile> {
  Users? user;

  Map<String, dynamic>? durationData; // should hold duration data

  @override
  void initState() {
    super.initState();

    // var holding passed data from parent
    final passedData = widget.event;
    final lat = passedData.latlng["lat"];
    final lng = passedData.latlng["lng"];

    // calling function to get distance and duration
    getDistanceDuration(lat, lng);

    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    // check if device is in light mode or dark mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    double imageWidth = 35.w;

    return InkWell(
      // move to event screen
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => EventScreen(
            durationData: durationData ?? {},
            event: widget.event,
          ),
        ),
      ),
      child: Container(
        height: 15.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(bottom: 2.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
              child: Image.network(
                widget.event.imageUrl, // event image url string
                height: 100.h,
                width: imageWidth,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CustomLoadingIndicator(
                    width: imageWidth,
                    height: null,
                  );
                },
                errorBuilder: (ctx, _, stacktrace) {
                  return SizedBox(
                    width: imageWidth,
                    child: const CustomImageErrorWidget(),
                  );
                },
              ),
            ),
            SizedBox(
              width: 1.w,
            ),

            // event details widget
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // event name
                  sizedBoxHolder(
                    Text(
                      widget.event.name,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // event venue
                  sizedBoxHolder(
                    Text(
                      widget.event.venue,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 9.sp, fontWeight: FontWeight.w500),
                    ),
                  ),

                  // event host data
                  sizedBoxHolder(
                    Row(
                      children: [
                        // host profile image
                        ProfileImage(
                          imageUrl: user?.imageUrl ?? "",
                          radius: 8.sp,
                          userId: widget.event.hostId,
                        ),

                        // some space
                        SizedBox(
                          width: 2.w,
                        ),
                        // host full name
                        SizedBox(
                          width: 35.w,
                          child: Text(
                            user?.name ?? "",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 8.sp),
                          ),
                        ),

                        // some spacing to push next widget to the extreme
                        const Spacer(),

                        // shows the event holds today
                        Text(
                          "Today",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 6.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getUser() {
    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    user = userProvider.getUser(widget.event.hostId);
  }

  // custom sized box widget method
  SizedBox sizedBoxHolder(Widget child) {
    return SizedBox(
      width: 52.w,
      child: child,
    );
  }

  // function to get user current location and calculating the
  //distance between current location and destination (event location)
  // collecting event LatLng
  Future<dynamic> getDistanceDuration(dynamic lat, dynamic lng) async {
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
