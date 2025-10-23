import 'package:flutter/material.dart';

/// A reusable frosted-glass effect card
class FrostedCard extends StatelessWidget {
  final Widget child;

  const FrostedCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.7)),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
