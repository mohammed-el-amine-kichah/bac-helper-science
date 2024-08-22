import 'package:flutter/material.dart';

class AppThemes {
  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(fontFamily: 'Rubik'),
      displayMedium: base.displayMedium!.copyWith(fontFamily: 'Rubik'),
      displaySmall: base.displaySmall!.copyWith(fontFamily: 'Rubik'),
      headlineMedium: base.headlineMedium!.copyWith(fontFamily: 'Rubik'),
      headlineSmall: base.headlineSmall!.copyWith(fontFamily: 'Rubik'),
      titleLarge: base.titleLarge!.copyWith(fontFamily: 'Rubik'),
      titleMedium: base.titleMedium!.copyWith(fontFamily: 'Rubik'),
      titleSmall: base.titleSmall!.copyWith(fontFamily: 'Rubik'),
      bodyLarge: base.bodyLarge!.copyWith(fontFamily: 'Rubik'),
      bodyMedium: base.bodyMedium!.copyWith(fontFamily: 'Rubik'),
      bodySmall: base.bodySmall!.copyWith(fontFamily: 'Rubik'),
    );
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: _buildTextTheme(Typography.material2021().black),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: _buildTextTheme(Typography.material2021().white),
  );
}