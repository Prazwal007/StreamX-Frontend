import 'package:flutter/material.dart';

@immutable
class AppColors {
  final Color background;
  final Color surface;
  final Color card;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;

  const AppColors({
    required this.background,
    required this.surface,
    required this.card,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
  });
}
