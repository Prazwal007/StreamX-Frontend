import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamx/theme/themecontroller.dart';
import 'theme/app_theme.dart';
import 'controllers/themecontroller.dart';
import 'controllers/downloads_controller.dart';
import 'controllers/categories_controller.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const DownloadManagerApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class DownloadManagerApp extends StatelessWidget {
  const DownloadManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DownloadsController()..init()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_)=>MultiThemeController()),
      ],
      child: Consumer<MultiThemeController>(
        builder: (context, themeCtrl, _) {
          return MaterialApp(
            title: 'Download Manager',
            debugShowCheckedModeBanner: false,
            theme:themeCtrl.theme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
