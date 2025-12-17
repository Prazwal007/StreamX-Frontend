import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ThemeController extends ChangeNotifier {
  // Start with dark theme
  bool _isDark = true;
  bool get isDark => _isDark;

  ThemeData get currentTheme => _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
