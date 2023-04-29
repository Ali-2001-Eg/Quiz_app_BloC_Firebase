import 'package:flutter/material.dart';
import 'light_theme.dart';

const Gradient mainGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    primaryLightColor,
    primaryRedColor,
  ],
);

Color customScaffoldColor(BuildContext context) =>
    const Color.fromARGB(255, 240, 237,255);

Color answerSelectedColor(BuildContext context) => Theme.of(context).primaryColor;
Color get answerBorderColor => const Color.fromARGB(255, 221, 221, 221);