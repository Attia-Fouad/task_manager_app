import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryColor, // Change this color to whatever you want
  ),
  primarySwatch: createMaterialColor(AppColors.primaryColor),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  primaryColor: AppColors.primaryColor,
  iconTheme: const IconThemeData(
    color: AppColors.iconsColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.greyTextColor,
    elevation: 20,
  ),
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
  ),
);

MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int strength in strengths) {
    final double ds = strength / 900;
    swatch[strength] = Color.fromRGBO(r, g, b, ds);
  }
  return MaterialColor(color.value, swatch);
}
