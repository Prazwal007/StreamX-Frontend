import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/top_toolbar.dart';
import '../components/categories_sidebar.dart';
import '../components/downloads_table.dart';
import '../controllers/downloads_controller.dart';
import '../theme/app_theme.dart';
import '../theme/themecontroller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Downlaods'),
        centerTitle: true,
        actions: [
          PopupMenuButton<AppThemeMode>(
            icon: const Icon(Icons.palette_outlined),
            onSelected: (mode) {
              context.read<MultiThemeController>().setTheme(mode);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: AppThemeMode.dark,
                child: Text('Dark'),
              ),
              PopupMenuItem(
                value: AppThemeMode.light,
                child: Text('Light'),
              ),
              PopupMenuItem(
                value: AppThemeMode.gray,
                child: Text('Gray'),
              ),
              PopupMenuItem(
                value: AppThemeMode.amoled,
                child: Text('AMOLED'),
              ),
              PopupMenuItem(
                value: AppThemeMode.midnight,
                child: Text('Midnight'),
              ),
              PopupMenuItem(
                value: AppThemeMode.nord,
                child: Text('Nord'),
              ),
               PopupMenuItem(
                value: AppThemeMode.dracula,
                child: Text('Dracula'),
              ),
               PopupMenuItem(
                value: AppThemeMode.gruvbox,
                child: Text('GruvBox'),
              ),
               PopupMenuItem(
                value: AppThemeMode.oneDark,
                child: Text('OneDark'),
              ),
               PopupMenuItem(
                value: AppThemeMode.tokyoNight,
                child: Text('Tokyo Night'),
              ),
               PopupMenuItem(
                value: AppThemeMode.paprika,
                child: Text('Paprika'),
              ),
               
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            const CategoriesSidebar(),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  TopToolbar(),
                  Divider(color:Theme.of(context).primaryColor,),
                  // SizedBox(height: 12),
                  Expanded(
                    child: DownloadsTable(),
                  ),
                ],
              ),
            ),
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
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.cardColor,
      title: Text(
        'New Download',
        style: theme.textTheme.bodyLarge,
      ),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Paste download URL',
        ),
        style: theme.textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final url = _controller.text.trim();
            if (url.isNotEmpty) {
              context.read<DownloadsController>().addFromUrl(url);
            }
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

