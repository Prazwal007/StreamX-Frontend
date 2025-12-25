import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../theme/theme_palette.dart';

enum AppThemeMode {
  dark,
  light,
  gray,
  amoled,
  midnight,
  solarized,
  nord,
  dracula,
  gruvbox,
  oneDark,
  tokyoNight,
  paprika,
}


class MultiThemeController extends ChangeNotifier {

  static const _prefsKey='app_theme_mode';
  AppThemeMode _mode = AppThemeMode.dark;

  AppThemeMode get mode => _mode;

  ThemeData get theme {
    switch (_mode) {
      case AppThemeMode.light:
        return AppTheme.fromColors(
          ThemePalettes.light,
          brightness: Brightness.light,
        );
      case AppThemeMode.gray:
        return AppTheme.fromColors(ThemePalettes.gray);
      case AppThemeMode.amoled:
        return AppTheme.fromColors(ThemePalettes.amoled);
      case AppThemeMode.midnight:
        return AppTheme.fromColors(ThemePalettes.midnight);
      case AppThemeMode.solarized:
        return AppTheme.fromColors(ThemePalettes.solarized);
      case AppThemeMode.nord:
        return AppTheme.fromColors(ThemePalettes.nord);
      case AppThemeMode.dracula:
        return AppTheme.fromColors(ThemePalettes.dracula);
      case AppThemeMode.gruvbox:
        return AppTheme.fromColors(ThemePalettes.gruvbox);
      case AppThemeMode.oneDark:
        return AppTheme.fromColors(ThemePalettes.oneDark);
      case AppThemeMode.tokyoNight:
        return AppTheme.fromColors(ThemePalettes.tokyoNight);
      case AppThemeMode.paprika:
        return AppTheme.fromColors(ThemePalettes.paprika);
        case AppThemeMode.dark:
      default:
        return AppTheme.fromColors(ThemePalettes.dark);
    }
  }

  MultiThemeController(){
    _loadTheme();
  }

  void setTheme(AppThemeMode mode) {
    _mode = mode;
    notifyListeners();
    _saveTheme();
  }

  Future<void>_saveTheme()async{

    final prefs=await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, _mode.index);

  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_prefsKey);
    if (index != null && index >= 0 && index < AppThemeMode.values.length) {
      _mode = AppThemeMode.values[index];
      notifyListeners();
    }
  }
}
