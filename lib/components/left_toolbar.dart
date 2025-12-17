import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LeftToolbar extends StatelessWidget {
  const LeftToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF0E0E0E),
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          IconButton(icon: const Icon(Icons.menu), color: AppTheme.neon, onPressed: () {}),
          const Divider(color: Colors.white12),
          _toolbarIcon(Icons.play_arrow),
          _toolbarIcon(Icons.download),
          _toolbarIcon(Icons.pause),
          const Spacer(),
          _toolbarIcon(Icons.settings),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _toolbarIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        child: Icon(icon, color: Colors.white70),
      ),
    );
  }
}
