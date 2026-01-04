
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData fromColors(
    AppColors c, {
    Brightness brightness = Brightness.dark,
  }) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      primaryColor: c.accent,
      cardColor: c.card,
      dividerColor: c.divider,
      focusColor: c.textPrimary,

      appBarTheme: AppBarTheme(
        backgroundColor: c.surface,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: c.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: c.textPrimary),
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(color: c.textPrimary),
        bodyMedium: TextStyle(color: c.textSecondary),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.accent,
      ),

      iconTheme: IconThemeData(color: c.textSecondary),
    );
  }
}
