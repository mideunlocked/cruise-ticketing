import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/distance_duration_helper.dart';
import '../../models/event.dart';
import '../../providers/users_provider.dart';
import '../../screens/event_screens/event_screen.dart';
import '../general_widgets/custom_image_error_widget.dart';
import '../general_widgets/custom_loading_indicator.dart';
import 'event_name_date_widget.dart';

class NearByTile extends StatefulWidget {
  const NearByTile({
    super.key,
    required this.event,
  });

  final Event event; // get event data

  @override
  State<NearByTile> createState() => _NearByTileState();
}

class _NearByTileState extends State<NearByTile> {
  double lat = 0;
  double lng = 0;

  Map<String, dynamic>? durationData; // should hold duration data

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // var holding passed data from parent
    final passedData = widget.event;
    lat = passedData.geoPoint.latitude;
    lng = passedData.geoPoint.longitude;
  }

  @override
  Widget build(BuildContext context) {
    // var of = Theme.of(context);
    // var primaryColor = of.primaryColor;

    // check if device is dark mode or light mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    double imageHeight = 12.h;

    var userProvider = Provider.of<UsersProvider>(context);

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          // move to event screen
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => FutureBuilder(
                  future: userProvider.getUser(widget.event.hostId),
                  builder: (context, snapshot) {
                    return EventScreen(
                      durationData: durationData ?? {},
                      event: widget.event,
                      host: snapshot.data,
                    );
                  }),
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
                    widget.event.imageUrl,
                    height: imageHeight,
                    width: 100.w,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CustomLoadingIndicator(
                        height: imageHeight,
                        width: null,
                      );
                    },
                    errorBuilder: (ctx, _, stacktrace) {
                      return SizedBox(
                        height: imageHeight,
                        child: const CustomImageErrorWidget(),
                      );
                    },
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
                        event: widget.event,
                        isStart: true,
                        largeText: false,
                      ),

                      // some space
                      SizedBox(
                        height: 0.5.h,
                      ),

                      // venue text widget
                      Text(
                        widget.event.venue,
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
              FutureBuilder(
                  future: DistanceAndDuration.getDistanceDuration(lat, lng),
                  builder: (context, snapshot) {
                    var circularProgressIndicator = SizedBox(
                      height: 2.h,
                      width: 4.w,
                      child: const CircularProgressIndicator(
                        color: Colors.black54,
                        backgroundColor: Colors.grey,
                        strokeWidth: 1,
                      ),
                    );

                    if (snapshot.hasError) {
                      return circularProgressIndicator;
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data;

                      return Text(
                        // else it has data display duration text
                        data?["duration"] ?? "",
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.black,
                        ),
                      );
                    }
                    return circularProgressIndicator;
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
