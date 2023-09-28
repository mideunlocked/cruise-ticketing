import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );

    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 1, 34),
          primaryColor: const Color(0xFF26DBB5),
          textTheme: TextTheme(
            bodyMedium: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              fontFamily: "Poppins",
              letterSpacing: 8.0,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF26DBB5).withOpacity(0.1),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            hintStyle: TextStyle(
              fontFamily: "Poppins",
              color: Colors.white54,
              fontSize: 8.sp,
              letterSpacing: 0,
            ),
          ),
        ),
        theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: TextTheme(
            // ignore: prefer_const_constructors
            bodyMedium: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
            ),
            titleMedium: TextStyle(
              fontFamily: "Poppins",
              letterSpacing: 8.0,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.black.withOpacity(0.1),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            hintStyle: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black26,
              fontSize: 8.sp,
              letterSpacing: 0,
            ),
          ),
        ),
        initialRoute: "/CreateEventScreen",
        routes: {
          Home.routeName: (context) => const Home(),
          TicketScreen.routeName: (context) => const TicketScreen(),
          CreateEventScreen.routeName: (context) => const CreateEventScreen(),
        },
      ),
    );
  }
}
