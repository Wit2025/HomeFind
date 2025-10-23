import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/technician_view.dart';
import 'package:homefind/screens/service/techView/widget/counterDialog.dart';
import 'package:homefind/screens/service/techView/widget/declineDialog.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/widgets/Colors.dart';

class TechActionButtons extends StatelessWidget {
  final ServiceRequestModel request;
  final String? requestState;
  final OnTechDecision? onDecision;
  final Function(String) onStateChange;

  const TechActionButtons({
    Key? key,
    required this.request,
    required this.requestState,
    required this.onDecision,
    required this.onStateChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // treat 'counter:<price>' as a counter status as well
    if (requestState == 'accepted' ||
        (requestState?.startsWith('counter') == true) ||
        requestState == 'counter' ||
        requestState == 'waiting') {
      // normalize param to simple key for _buildStatusMessage
      final statusKey = requestState?.startsWith('counter') == true
          ? 'counter'
          : requestState!;
      return _buildStatusMessage(statusKey);
    }

    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.close_rounded,
            text: 'ປະຕິເສດ',
            backgroundColor: Colors.white,
            textColor: Colors.red,
            borderColor: Colors.red,
            onPressed: () => _showDeclineConfirmation(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.currency_exchange_rounded,
            text: 'ສະເໜີລາຄາ',
            backgroundColor: Colors.white,
            textColor: AppColors.color2,
            borderColor: AppColors.color2,
            onPressed: () => _showCounterDialog(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.check_rounded,
            text: 'ຮັບວຽກ',
            backgroundColor: AppColors.color1,
            textColor: Colors.white,
            borderColor: AppColors.color1,
            onPressed: _acceptRequest,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusMessage(String requestState) {
    String message = '';
    Color color = AppColors.color1;

    if (requestState == 'accepted') {
      message = 'ຮັບວຽກນີ້ແລ້ວ';
      color = Colors.green;
    } else if (requestState == 'counter') {
      message = 'ສະເໜີລາຄາໃໝ່ແລ້ວ';
      color = Colors.orange;
    } else if (requestState == 'waiting') {
      message = 'ກຳລັງລໍຖ້າການຕອບກັບ...';
      color = AppColors.color2;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (requestState == 'waiting') ...[
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(width: 12),
          ] else ...[
            Icon(
              requestState == 'accepted'
                  ? Icons.check_circle
                  : Icons.currency_exchange_rounded,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 12),
          ],
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: backgroundColor == AppColors.color1
            ? [
                BoxShadow(
                  color: AppColors.color1.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 15),
        label: Text(
          text,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: borderColor, width: 1.5),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  void _acceptRequest() {
    onStateChange('waiting');
    onDecision?.call(request.id, 'accepted');
    onStateChange('accepted');
  }

  void _showDeclineConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DeclineDialog(
        request: request,
        onDecline: () {
          onStateChange('declined');
          onDecision?.call(request.id, 'declined');
        },
      ),
    );
  }

  void _showCounterDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>?>(
      context: context,
      builder: (context) => CounterDialog(request: request),
    );

    if (result != null) {
      final counterPrice = result['price'] as double;
      final description = result['description'] as String;

      onStateChange('waiting');
      onDecision?.call(
        request.id,
        'counter',
        counterPrice: counterPrice,
        description: description.isNotEmpty ? description : null,
      );
      // include the counter price in the local state so the tech UI can show new vs old
      onStateChange('counter:${counterPrice.toString()}');
    }
  }
}
