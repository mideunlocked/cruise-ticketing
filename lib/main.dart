import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'screens/home.dart';
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
        darkTheme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 1, 34),
          primaryColor: const Color(0xFF26DBB5),
          textTheme: TextTheme(
            bodyMedium: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              letterSpacing: 8.0,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
              letterSpacing: 8.0,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        initialRoute: "/",
        routes: {
          Home.routeName: (context) => const Home(),
          TicketScreen.routeName: (context) => const TicketScreen(),
        },
      ),
    );
  }
}
