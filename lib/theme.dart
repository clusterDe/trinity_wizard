import 'package:flutter/material.dart';
import 'package:trinity_wizard/constant.dart';

class DataTheme {
  static themeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: orangeColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: defPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defBorderRadius),
        ),
      ),
    );
  }
}
