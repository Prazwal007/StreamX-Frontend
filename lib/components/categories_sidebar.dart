import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoriesSidebar extends StatelessWidget {
  const CategoriesSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;
    final neon = AppTheme.neon;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _categoryHeader('All Downloads', icon: Icons.folder, neon: neon, textColor: textColor),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                _categoryItem('Compressed', Icons.archive, textColor),
                _categoryItem('Documents', Icons.description, textColor),
                _categoryItem('Music', Icons.music_note, textColor),
                _categoryItem('Program', Icons.code, textColor),
                _categoryItem('Video', Icons.movie, textColor),
                Divider(color: textColor?.withOpacity(0.3)),
                _categoryCollapsible('Queues', ['Queue 1', 'Queue 2'], textColor),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryHeader(String title,
      {required IconData icon, required Color neon, required Color? textColor}) {
    return Row(
      children: [
        Icon(icon, color: neon),
        const SizedBox(width: 8),
        Text(title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: textColor)),
      ],
    );
  }

  Widget _categoryItem(String title, IconData icon, Color? textColor) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Icon(icon, color: textColor?.withOpacity(0.7)),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(color: textColor)),
          ],
        ),
      );

  Widget _categoryCollapsible(String title, List<String> items, Color? textColor) =>
      ExpansionTile(
        collapsedIconColor: textColor?.withOpacity(0.7),
        iconColor: AppTheme.neon,
        title: Text(title, style: TextStyle(color: textColor)),
        children: items
            .map((e) => ListTile(
                  title: Text(e, style: TextStyle(color: textColor)),
                  dense: true,
                ))
            .toList(),
      );
}
