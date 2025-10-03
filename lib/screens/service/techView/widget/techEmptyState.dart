import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';

class TechEmptyState extends StatelessWidget {
  const TechEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.color1.withOpacity(0.1),
                  AppColors.color2.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.handyman_outlined,
              size: 50,
              color: AppColors.color1.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'ບໍ່ມີວຽກທີ່ຕ້ອງບໍລິການ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.color1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ວຽກບໍລິການໃໝ່ຈະສະແດງບ່ອນນີ້',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.color2.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
