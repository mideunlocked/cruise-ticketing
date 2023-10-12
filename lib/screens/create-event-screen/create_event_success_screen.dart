import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/event_provider.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../event_screens/event_screen.dart';

class EventCreateSuccessScreen extends StatelessWidget {
  static const routeName = "/EventCreateSuccessScreen";
  const EventCreateSuccessScreen({super.key});

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
                function: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => EventScreen(
                          durationData: const {},
                          event: eventProvider.events.last,
                          isInitial: true,
                        ),
                      ),
                      (route) => false);
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
