import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'helpers/themes_helper.dart';
import 'screens/home.dart';
import 'screens/create-event-screen/create_event.dart';
import 'screens/ticket_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemesHelper.lightTheme,
        theme: ThemesHelper.lightTheme,
        initialRoute: "/",
        routes: {
          Home.routeName: (context) => const Home(),
          TicketScreen.routeName: (context) => const TicketScreen(),
          CreateEventScreen.routeName: (context) => const CreateEventScreen(),
        },
      ),
    );
  }
}
