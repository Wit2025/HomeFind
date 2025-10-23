import 'package:flutter/material.dart';
import 'package:homefind/screens/service/chat/chat_service.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/widgets/colors.dart';

class TechRequestCardHeader extends StatelessWidget {
  final ServiceRequestModel request;
  final String? requestState;

  const TechRequestCardHeader({
    super.key,
    required this.request,
    required this.requestState,
  });

  @override
  Widget build(BuildContext context) {
    final (statusText, statusColor) = _getStatusInfo();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            const SizedBox(width: 12),
            _buildUserInfo(),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildChatButton(context, statusColor),
            const SizedBox(width: 10),
            _buildStatusBadge(statusText, statusColor),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.color1, AppColors.color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.color1.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.person_outlined, color: Colors.white, size: 24),
    );
  }

  Widget _buildUserInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            request.serviceType,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.color1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            'ຈາກ ${request.requesterName}',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.color2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatButton(BuildContext context, Color statusColor) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              serviceId: request.id,
              serviceName: request.requesterName,
              serviceType: request.serviceType,
              serviceIcon: Icons.handyman_rounded,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [statusColor, statusColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: statusColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          'ສົ່ງຂໍ້ຄວາມ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String statusText, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor, statusColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        statusText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  (String, Color) _getStatusInfo() {
    String statusText = 'ໃໝ່';
    Color statusColor = AppColors.color1;

    if (requestState == 'accepted') {
      statusText = 'ຮັບວຽກນີ້ແລ້ວ';
      statusColor = Colors.green;
    } else if (requestState?.startsWith('counter') == true) {
      statusText = 'ສະເໜີລາຄາໃໝ່ແລ້ວ';
      statusColor = Colors.orange;
    } else if (requestState == 'waiting') {
      statusText = 'ລໍຖ້າຢູ່';
      statusColor = AppColors.color2;
    }

    return (statusText, statusColor);
  }
}
