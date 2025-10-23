import 'package:flutter/material.dart';
import 'package:homefind/widgets/colors.dart';

// This widget displays the two-step progress indicator at the top of the page.
class ProgressIndicatorSection extends StatelessWidget {
  const ProgressIndicatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Step 1 - Active
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.color1,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.color1.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
          Container(
            height: 2,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          // Step 2 - Inactive
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.home, color: Colors.grey[600], size: 20),
          ),
        ],
      ),
    );
  }
}
