import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../pages/categories_page.dart';
import "../pages/home_page.dart";

class CategoriesSidebar extends StatelessWidget {
  const CategoriesSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _categoryHeader(context, 'Recent Downloads', Icons.folder, 'all'),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                _categoryItem(context, 'Compressed', Icons.archive, 'compressed'),
                _categoryItem(context, 'Documents', Icons.description, 'documents'),
                _categoryItem(context, 'Music', Icons.music_note, 'music'),
                _categoryItem(context, 'Program', Icons.code, 'program'),
                _categoryItem(context, 'Video', Icons.movie, 'video'),
                const Divider(color: Colors.white12),
                _categoryCollapsible(context, 'Queues', ['Queue 1', 'Queue 2']),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryHeader(
    BuildContext context,
    String title,
    IconData icon,
    String category,
  ) {
    return InkWell(
      onTap: () => _openHome(context, category, title),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.neon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(
    BuildContext context,
    String title,
    IconData icon,
    String category,
  ) {
    return InkWell(
      onTap: () => _openCategory(context, category, title),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _categoryCollapsible(
    BuildContext context,
    String title,
    List<String> items,
  ) {
    return ExpansionTile(
      collapsedIconColor: Colors.white70,
      iconColor: AppTheme.neon,
      title: Text(title),
      children: items.map((queue) {
        return ListTile(
          dense: true,
          title: Text(queue),
          onTap: () => _openCategory(context, queue.toLowerCase(), queue),
        );
      }).toList(),
    );
  }

  void _openCategory(BuildContext context, String category, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryFilesPage(
          category: category,
          title: title,
        ),
      ),
    );
  }

  void _openHome(BuildContext context, String category, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );
  }
}
