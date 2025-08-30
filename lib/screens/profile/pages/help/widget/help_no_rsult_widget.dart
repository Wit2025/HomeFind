import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class HelpNoResultsWidget extends StatelessWidget {
  final VoidCallback onClearSearch;

  const HelpNoResultsWidget({
    super.key,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              S.of(context).noSearchResults,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).tryOtherKeywords,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onClearSearch,
              icon: const Icon(Icons.refresh),
              label: Text(S.of(context).clearSearch),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C697A),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}