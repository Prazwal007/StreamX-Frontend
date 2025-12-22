import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/left_toolbar.dart';
import '../components/categories_sidebar.dart';
import '../components/downloads_table.dart';
import '../theme/themecontroller.dart';
import '../controllers/downloads_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Manager'),
        actions: [
          // Theme toggle button
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => Provider.of<ThemeController>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: const [
            LeftToolbar(),
            SizedBox(width: 12),
            CategoriesSidebar(),
            SizedBox(width: 12),
            Expanded(child: DownloadsTable()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const _AddDownloadDialog());
  }
}

class _AddDownloadDialog extends StatefulWidget {
  const _AddDownloadDialog();
  @override
  State<_AddDownloadDialog> createState() => _AddDownloadDialogState();
}

class _AddDownloadDialogState extends State<_AddDownloadDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeController>(context).isDark;
    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      title: const Text('New Download', style:  TextStyle(color: Colors.white)),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Paste download URL',
          hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black45),
        ),
        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1DB954),
          ),
          onPressed: () {
            final url = _controller.text.trim();
            if (url.isNotEmpty) {
              // Add via provider
              final prov = Provider.of<DownloadsController>(context, listen: false);
              prov.addFromUrl(url);
            }
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
