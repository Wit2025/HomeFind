import 'package:flutter/material.dart';

// Helper classes for data structure
class HelpItem {
  final IconData icon;
  final String title;
  final String subtitle;

  HelpItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class FaqItem {
  final String question;

  FaqItem({required this.question});
}