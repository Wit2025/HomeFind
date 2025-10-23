import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/widgets/colors.dart';

class TechStatsCards extends StatelessWidget {
  final List<ServiceRequestModel> requests;
  final String? Function(ServiceRequestModel) getRequestState;

  const TechStatsCards({
    super.key,
    required this.requests,
    required this.getRequestState,
  });

  @override
  Widget build(BuildContext context) {
    final newRequests = requests
        .where((request) => getRequestState(request) == null)
        .length;
    final pendingRequests = requests
        .where(
          (request) =>
              getRequestState(request) != null &&
              getRequestState(request) != 'declined',
        )
        .length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            value: newRequests.toString(),
            label: 'ວຽກໃໝ່',
            icon: Icons.new_releases_outlined,
            color: AppColors.color1,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            value: pendingRequests.toString(),
            label: 'ລໍຖ້າຢູ່',
            icon: Icons.schedule_outlined,
            color: AppColors.color2,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
