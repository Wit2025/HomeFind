import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/widgets/colors.dart';

class TechRequestCardDescription extends StatelessWidget {
  final ServiceRequestModel request;

  const TechRequestCardDescription({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.color2.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.color2.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              request.description.isNotEmpty
                  ? request.description
                  : 'ບໍ່ມີຄຳອະທິບາຍຂອງວຽກ',
              style: TextStyle(
                color: AppColors.color1.withValues(alpha: 0.8),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
