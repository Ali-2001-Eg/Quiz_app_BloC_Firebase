import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

mixin SubThemeData {
  TextTheme get getTextTheme => GoogleFonts.quicksandTextTheme(const TextTheme(
      bodyLarge: TextStyle(fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontWeight: FontWeight.w400)));
  IconThemeData get getIconTheme =>
      IconThemeData(color: Colors.white, size: 16.h);
}
