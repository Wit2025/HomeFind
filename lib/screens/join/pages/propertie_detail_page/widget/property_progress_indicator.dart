// widgets/property_progress_indicator.dart
import 'package:flutter/material.dart';
import 'package:homefind/screens/join/pages/personal_info_page/persional_info_page.dart';

class PropertyProgressIndicator extends StatelessWidget {
  final Color primaryColor;

  const PropertyProgressIndicator({
    super.key,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Step 1 - Completed
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PersonalInfoPage()),
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
          Container(
            height: 2,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          // Step 2 - Active
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.home, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}