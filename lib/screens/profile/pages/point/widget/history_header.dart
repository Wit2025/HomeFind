import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class HistoryHeader extends StatelessWidget {
  final VoidCallback onShowAll;

  const HistoryHeader({
    super.key,
    required this.onShowAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.history, color: Colors.black, size: 24),
          const SizedBox(width: 8),
          Text(
            S.of(context).scoreHistory,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: onShowAll,
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              padding: EdgeInsets.zero,
            ),
            child: Text(
              S.of(context).all,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
