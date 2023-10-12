import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ThemesHelper {
  static final outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.black,
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
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
    cardTheme: CardTheme(
      elevation: 2.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      surfaceTintColor: Colors.white,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
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
  );
}


// ThemeData(
//           scaffoldBackgroundColor: const Color.fromARGB(255, 0, 1, 34),
//           primaryColor: const Color(0xFF26DBB5),
//           textTheme: TextTheme(
//             bodyMedium: const TextStyle(
//               fontFamily: "Poppins",
//               color: Colors.white,
//             ),
//             titleMedium: TextStyle(
//               fontFamily: "Poppins",
//               letterSpacing: 8.0,
//               fontSize: 13.sp,
//               fontWeight: FontWeight.w500,
//               color: Colors.white,
//             ),
//           ),
//           cardTheme: CardTheme(
//             elevation: 2.h,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             color: const Color.fromARGB(255, 0, 2, 48),
//           ),
//           bottomSheetTheme: BottomSheetThemeData(
//             backgroundColor: const Color.fromARGB(255, 0, 1, 34),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           inputDecorationTheme: InputDecorationTheme(
//             filled: true,
//             fillColor: const Color(0xFF26DBB5).withOpacity(0.1),
//             border: outlineInputBorder,
//             enabledBorder: outlineInputBorder,
//             focusedBorder: outlineInputBorder,
//             hintStyle: TextStyle(
//               fontFamily: "Poppins",
//               color: Colors.white54,
//               fontSize: 8.sp,
//               letterSpacing: 0,
//             ),
//           ),
//         )