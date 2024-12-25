import 'package:donezo/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColor.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF1F1F1),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(),
  );
}
