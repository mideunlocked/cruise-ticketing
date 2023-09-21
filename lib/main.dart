import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'screens/home.dart';

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
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 1, 34),
          primaryColor: const Color.fromARGB(255, 0, 255, 170),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
            ),
          ),
        ),
        initialRoute: "/",
        routes: {
          Home.routeName: (context) => const Home(),
        },
      ),
    );
  }
}
