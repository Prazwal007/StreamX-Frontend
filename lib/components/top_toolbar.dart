import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';

class TopToolbar extends StatelessWidget {
  const TopToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color:Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          _toolbarIcon(Icons.play_arrow,context),
          _toolbarIcon(Icons.download,context),
          _toolbarIcon(Icons.pause,context),
         
        ],
      ),
    );
  }

  Widget _toolbarIcon(IconData icon,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        child: Icon(icon, color: Theme.of(context).focusColor),
      ),
    );
  }
}
