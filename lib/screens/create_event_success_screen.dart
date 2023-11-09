import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/event.dart';
import '../providers/users_provider.dart';
import '../widgets/general_widgets/custom_button.dart';
import 'event_screens/event_screen.dart';

class EventCreateSuccessScreen extends StatefulWidget {
  static const routeName = "/EventCreateSuccessScreen";
  const EventCreateSuccessScreen({super.key});

  @override
  State<EventCreateSuccessScreen> createState() =>
      _EventCreateSuccessScreenState();
}

class _EventCreateSuccessScreenState extends State<EventCreateSuccessScreen> {
  Event? event;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    event = ModalRoute.of(context)!.settings.arguments as Event;
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);

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
                  if (mounted) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => FutureBuilder(
                            future: userProvider.getUser(event?.hostId ?? ""),
                            builder: (context, snapshot) {
                              return EventScreen(
                                durationData: {},
                                event: event!,
                                host: snapshot.data,
                                isInitial: true,
                              );
                            },
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
