import 'package:flutter/material.dart';
import 'app_colors.dart';

class ThemePalettes {

  // 1. DARK
  static const dark = AppColors(
    background: Color(0xFF0B0B0B),
    surface: Color(0xFF121212),
    card: Color(0xFF161616),
    accent: Color(0xFF1DB954),
    textPrimary: Color(0xFFEDEDED),
    textSecondary: Colors.white70,
    divider: Colors.white12,
  );

  // 2. LIGHT
  static const light = AppColors(
    background: Color(0xFFF5F5F5),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFF0F0F0),
    accent: Color(0xFF1DB954),
    textPrimary: Color(0xFF000000),
    textSecondary: Colors.black54,
    divider: Colors.black12,
  );

  // 3. GRAY / NEUTRAL
  static const gray = AppColors(
    background: Color(0xFF1E1D1D),
    surface: Color(0xFF2A2A2A),
    card: Color(0xFF303030),
    accent: Color(0xFF4CAF50),
    textPrimary: Color(0xFFEDEDED),
    textSecondary: Colors.white60,
    divider: Colors.white24,
  );

  // 4. AMOLED (TRUE BLACK)
  static const amoled = AppColors(
    background: Colors.black,
    surface: Colors.black,
    card: Color(0xFF050505),
    accent: Color(0xFF1DB954),
    textPrimary: Color(0xFFEDEDED),
    textSecondary: Colors.white60,
    divider: Colors.white10,
  );

  // 5. MIDNIGHT BLUE
  static const midnight = AppColors(
    background: Color(0xFF050B1E),
    surface: Color(0xFF0B1437),
    card: Color(0xFF101C4A),
    accent: Color(0xFF4FC3F7),
    textPrimary: Color(0xFFE3F2FD),
    textSecondary: Colors.white70,
    divider: Colors.white24,
  );

  // 6. SOLARIZED DARK
  static const solarized = AppColors(
    background: Color(0xFF002B36),
    surface: Color(0xFF073642),
    card: Color(0xFF0A4B5A),
    accent: Color(0xFF2AA198),
    textPrimary: Color(0xFFEEE8D5),
    textSecondary: Color(0xFF93A1A1),
    divider: Color(0xFF586E75),
  );
    // 7. NORD
  static const nord = AppColors(
    background: Color(0xFF2E3440),
    surface: Color(0xFF3B4252),
    card: Color(0xFF434C5E),
    accent: Color(0xFF88C0D0),
    textPrimary: Color(0xFFECEFF4),
    textSecondary: Color(0xFFD8DEE9),
    divider: Color(0xFF4C566A),
  );

  // 8. DRACULA
  static const dracula = AppColors(
    background: Color(0xFF282A36),
    surface: Color(0xFF343746),
    card: Color(0xFF3C3F58),
    accent: Color(0xFFFF79C6),
    textPrimary: Color(0xFFF8F8F2),
    textSecondary: Color(0xFFBFBFBF),
    divider: Color(0xFF44475A),
  );

  // 9. GRUVBOX DARK
  static const gruvbox = AppColors(
    background: Color(0xFF1D2021),
    surface: Color(0xFF282828),
    card: Color(0xFF32302F),
    accent: Color(0xFFFB4934),
    textPrimary: Color(0xFFEBDBB2),
    textSecondary: Color(0xFFD5C4A1),
    divider: Color(0xFF3C3836),
  );

  // 10. ONE DARK
  static const oneDark = AppColors(
    background: Color(0xFF21252B),
    surface: Color(0xFF282C34),
    card: Color(0xFF2C313A),
    accent: Color(0xFF61AFEF),
    textPrimary: Color(0xFFABB2BF),
    textSecondary: Color(0xFF9DA5B4),
    divider: Color(0xFF3E4451),
  );

  // 11. TOKYO NIGHT
  static const tokyoNight = AppColors(
    background: Color(0xFF1A1B26),
    surface: Color(0xFF24283B),
    card: Color(0xFF2F334D),
    accent: Color(0xFF7AA2F7),
    textPrimary: Color(0xFFC0CAF5),
    textSecondary: Color(0xFF9AA5CE),
    divider: Color(0xFF414868),
  );

  // 12. PAPRIKA (Inspired by the movie)
  static const paprika = AppColors(
    background: Color(0xFF1B0B12), // deep surreal crimson-black
    surface: Color(0xFF2A0F1D),
    card: Color(0xFF3A1426),
    accent: Color(0xFFFF3D57), // bold paprika red
    textPrimary: Color(0xFFFFE4EC),
    textSecondary: Color(0xFFFFB3C1),
    divider: Color(0xFF6A1B3A),
  );

}
