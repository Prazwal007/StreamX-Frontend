import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'theme/themecontroller.dart';
import 'controllers/downloads_controller.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const DownloadManagerApp());
}

class DownloadManagerApp extends StatelessWidget {
  const DownloadManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DownloadsController()..init()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeCtrl, _) {
          return MaterialApp(
            title: 'Download Manager',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeCtrl.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
