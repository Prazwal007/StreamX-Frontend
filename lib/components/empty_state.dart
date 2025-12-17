import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No downloads yet",
        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 16),
      ),
    );
  }
}
