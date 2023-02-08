import 'package:flutter/material.dart';

class ConstantColors {
  static const List<Color> colorStatus = [
    ConstantColors.primary2,
    ConstantColors.primary,
    ConstantColors.primary4,
  ];
  static const Color headerText = Color(0xff565656);
  static const Color backGround = Color(0xff4A4A4A);
  static const Color lightGrey = Color(0xff666666);
  static const Color primary = Color(0xff00CC51);
  static const Color secondary = Color(0xFF08B89D);
  static const Color primary4 = Color(0xffFF5C00);
  static const Color errorColor = Color.fromARGB(255, 255, 0, 0);
  static const Color primar3 = Color(0xffCDE8DF);
  static const Color primary2 = Color(0xff0575E6);
  static const MaterialColor mainColor = MaterialColor(
    0xffCDE8DF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffCDE8DF),
      100: Color(0xffCDE8DF),
      200: Color(0xffCDE8DF),
      300: Color(0xffCDE8DF),
      400: Color(0xffCDE8DF),
      500: Color(0xffCDE8DF),
      600: Color(0xffCDE8DF),
      700: Color(0xffCDE8DF),
      800: Color(0xffCDE8DF),
      900: Color(0xffCDE8DF), //10%
    },
  );
}
