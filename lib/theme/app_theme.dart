import 'package:flutter/material.dart';
import 'package:sic_management_app/constants/constant_color.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: ConstantColors.secondary,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ConstantColors.secondary,
    ),
  );
}
