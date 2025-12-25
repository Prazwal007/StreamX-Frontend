// import 'package:flutter/material.dart';

// class AppTheme {
//   // Colors
//   static const Color bgDark = Color(0xFF0B0B0B);
//   static const Color surfaceDark = Color(0xFF121212);
//   static const Color cardDark = Color(0xFF161616);
//   static const Color neon = Color(0xFF1DB954);
//   static const Color textDark = Color(0xFFEDEDED);

//   static const Color bgGray=Color.fromARGB(255, 30, 29, 29);

//   static const Color bgLight = Color(0xFFF5F5F5);
//   static const Color surfaceLight = Color(0xFFFFFFFF);
//   static const Color cardLight = Color(0xFFF0F0F0);
//   static const Color textLight = Color(0xFF000000);

//   // Dark theme
//   static final darkTheme = ThemeData.dark().copyWith(
//     scaffoldBackgroundColor: bgDark,
//     canvasColor: bgDark,
//     primaryColor: neon,
//     cardColor: cardDark,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: surfaceDark,
//       elevation: 0,
//       titleTextStyle: TextStyle(color: textDark, fontSize: 18, fontWeight: FontWeight.w600),
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: textDark),
//       bodyMedium: TextStyle(color: Colors.white70),
//     ),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       backgroundColor: neon,
//     ),
//     dividerColor: Colors.white12,
//   );

//   // Light theme
//   static final lightTheme = ThemeData.light().copyWith(
//     scaffoldBackgroundColor: bgLight,
//     canvasColor: bgLight,
//     primaryColor: neon,
//     cardColor: cardLight,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: surfaceLight,
//       elevation: 0,
//       titleTextStyle: TextStyle(color: textLight, fontSize: 18, fontWeight: FontWeight.w600),
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: textLight),
//       bodyMedium: TextStyle(color: Colors.black54),
//     ),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//       backgroundColor: neon,
//     ),
//     dividerColor: Colors.black12,
//   );
// }
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
