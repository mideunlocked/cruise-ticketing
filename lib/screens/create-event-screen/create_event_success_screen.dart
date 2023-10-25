import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/distance_duration_helper.dart';
import '../../models/event.dart';
import '../../providers/event_provider.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../event_screens/event_screen.dart';

class EventCreateSuccessScreen extends StatefulWidget {
  static const routeName = "/EventCreateSuccessScreen";
  const EventCreateSuccessScreen({super.key});

  @override
  State<EventCreateSuccessScreen> createState() =>
      _EventCreateSuccessScreenState();
}

class _EventCreateSuccessScreenState extends State<EventCreateSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/",
          (route) => false,
        );
        throw 1;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/check_calendar.png",
                height: 40.h,
                width: 50.w,
              ),
              const Text(
                "Your event has been successfully set up. Ready to make it unforgettable!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              CustomButton(
                title: "View event",
                function: () async {
                  Event newEvent = eventProvider.events.last;
                  dynamic latLng = newEvent.latlng;

                  final durationData =
                      await DistanceAndDuration.getDistanceDuration(
                    latLng["lat"],
                    latLng["lng"],
                  );

                  if (mounted) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => EventScreen(
                            durationData: durationData,
                            event: newEvent,
                            isInitial: true,
                          ),
                        ),
                        (route) => false);
                  }
                },
              ),
              CustomButton(
                title: "Go to home",
                function: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/",
                    (route) => false,
                  );
                },
                isInactive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
