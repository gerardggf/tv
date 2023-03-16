import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData getTheme(bool darkMode) {
  if (darkMode) {
    final darkTheme = ThemeData.dark();

    return darkTheme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        elevation: 0,
      ),
      scaffoldBackgroundColor: AppColors.darkLight,
      canvasColor: AppColors.dark,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(
          Colors.blue,
        ),
        trackColor: MaterialStateProperty.all(
          Colors.lightBlue.withOpacity(0.5),
        ),
      ),
      textTheme: GoogleFonts.nunitoSansTextTheme(
        darkTheme.textTheme,
      ),
    );
  }
  final lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.dark),
      titleTextStyle: TextStyle(color: AppColors.dark),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.dark,
    ),
    textTheme: GoogleFonts.nunitoSansTextTheme(
      lightTheme.textTheme.copyWith(
        titleSmall: const TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
