import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {

  static ProgressIndicatorThemeData get _progressTheme {

    return ProgressIndicatorThemeData(
      color: AppColors.themeColor,
    );

  }

  static final ThemeData _lightTheme = ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    progressIndicatorTheme: _progressTheme,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    filledButtonTheme: filledButtonTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    appBarTheme: appBarTheme
  );

  static final ThemeData _darkTheme = ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    brightness: Brightness.dark,
    progressIndicatorTheme: _progressTheme
  );

  static ThemeData get lightTheme => _lightTheme;

  static ThemeData get darkTheme => _darkTheme;

  static TextTheme get textTheme => const TextTheme(
      titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: .bold
      ),
      bodyLarge: TextStyle(
          color: Colors.grey,
          fontWeight: .bold
      ),
      bodyMedium: TextStyle(
          color: AppColors.themeColor,
          fontSize: 16
      )
  );

  static InputDecorationTheme get inputDecorationTheme => const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.themeColor, width: 1)
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColors.themeColor, width: 1)
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: AppColors.themeColor, width: 1)
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 1
        )
    ),
  );

  static AppBarTheme get appBarTheme => AppBarTheme(
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black54,
    )
  );

  static FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      fixedSize: const Size.fromWidth(double.maxFinite),
      padding: const EdgeInsets.symmetric(vertical: 12),
      textStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
    )
  );

  static BottomNavigationBarThemeData get bottomNavigationBarTheme => BottomNavigationBarThemeData(
    selectedItemColor: AppColors.themeColor,
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
  );

}