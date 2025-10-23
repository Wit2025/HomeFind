import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/tech_request_card/widget/tech_card_description.dart';
import 'package:homefind/screens/service/techView/tech_request_card/widget/tech_card_header.dart';
import 'package:homefind/screens/service/techView/tech_request_card/widget/tech_card_image.dart';
import 'package:homefind/screens/service/techView/tech_request_card/widget/tech_card_location.dart';
import 'package:homefind/screens/service/techView/tech_request_card/widget/tech_card_price.dart';
import 'package:homefind/screens/service/techView/technician_view.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/screens/service/techView/widget/tech_action_button.dart';
import 'package:homefind/widgets/colors.dart';

class TechRequestCard extends StatelessWidget {
  final ServiceRequestModel request;
  final String? requestState;
  final OnTechDecision? onDecision;
  final Function(String) onStateChange;

  const TechRequestCard({
    super.key,
    required this.request,
    required this.requestState,
    required this.onDecision,
    required this.onStateChange,
  });

  @override
  Widget build(BuildContext context) {
    final hasImages = request.attachments
        .where((a) => a.type == MediaType.image)
        .isNotEmpty;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.color1.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TechRequestCardHeader(
                  request: request,
                  requestState: requestState,
                ),
                const SizedBox(height: 16),
                if (hasImages) ...[
                  TechRequestCardImage(request: request),
                  const SizedBox(height: 16),
                ],
                if (request.location != null) ...[
                  TechRequestCardLocation(request: request),
                  const SizedBox(height: 12),
                ],
                TechRequestCardDescription(request: request),
                const SizedBox(height: 16),
                _buildDivider(),
                const SizedBox(height: 16),
                TechRequestCardPrice(
                  request: request,
                  requestState: requestState,
                ),
                const SizedBox(height: 16),
                TechActionButtons(
                  request: request,
                  requestState: requestState,
                  onDecision: onDecision,
                  onStateChange: onStateChange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.color1.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
