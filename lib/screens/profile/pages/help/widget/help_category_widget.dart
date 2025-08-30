import 'package:flutter/material.dart';

class HelpCategoryWidget extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const HelpCategoryWidget({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C697A),
            ),
          ),
        ),
        Column(
          children: items
              .map(
                (item) => Column(
                  children: [
                    item,
                    if (item != items.last) const SizedBox(height: 12),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}