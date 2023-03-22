import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData getTheme(bool darkMode) {
  if (darkMode) {
    final darkTheme = ThemeData.dark();
    final textTheme = darkTheme.textTheme;
    const boldStyle = TextStyle(fontWeight: FontWeight.bold);
    const whiteStyle = TextStyle(color: Colors.white);
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
        textTheme.copyWith(
          titleSmall: textTheme.titleSmall?.merge(boldStyle),
          titleMedium: textTheme.titleMedium?.merge(boldStyle),
          titleLarge: textTheme.titleLarge?.merge(boldStyle),
          bodySmall: textTheme.bodySmall?.merge(whiteStyle),
        ),
      ),
    );
  }
  final lightTheme = ThemeData.light();
  final textTheme = lightTheme.textTheme;
  const boldStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );
  const darkStyle = TextStyle(color: Colors.black);
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
      textTheme.copyWith(
        titleSmall: textTheme.titleSmall?.merge(boldStyle),
        titleMedium: textTheme.titleMedium?.merge(boldStyle),
        titleLarge: textTheme.titleLarge?.merge(boldStyle),
        bodySmall: textTheme.bodySmall?.merge(darkStyle),
      ),
    ),
  );
}
