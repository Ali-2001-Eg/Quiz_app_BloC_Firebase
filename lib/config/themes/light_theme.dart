import 'package:firebase_app/config/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/widgets/sub_theme_data_mixin.dart';

const Color primaryLightColor = Color(0xff3ac3cb);
const Color primaryRedColor = Color(0xfff85187);
const Color mainTextColor = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 245, 245, 255);
TextStyle questionTS = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800);

class LightTheme with SubThemeData {
  ThemeData get buildLightTheme {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      iconTheme: getIconTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: cardColor,
      primaryColor: primaryRedColor,
      textTheme: getTextTheme.apply(
        bodyColor: mainTextColor,
        displayColor: mainTextColor,
      ),
    );
  }

  static TextStyle get cartTitles => TextStyle(color: primaryRedColor, fontWeight: FontWeight.bold, fontSize: 18.sp);
  static TextStyle get detailsText => TextStyle(fontSize: 8.sp);
  static TextStyle get appBarText => TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.white);
  static TextStyle get countDownTimer => const TextStyle(color:primaryRedColor, letterSpacing: 2,);
}
