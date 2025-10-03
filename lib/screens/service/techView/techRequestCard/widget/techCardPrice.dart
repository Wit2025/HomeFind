import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:intl/intl.dart';

class TechRequestCardPrice extends StatelessWidget {
  final ServiceRequestModel request;
  final String? requestState;

  const TechRequestCardPrice({
    Key? key,
    required this.request,
    required this.requestState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ລາຄາທີ່ສະເໜີ',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.color1,
            fontWeight: FontWeight.w600,
          ),
        ),
        _buildPriceContent(),
      ],
    );
  }

  Widget _buildPriceContent() {
    final counterPrice = _getCounterPrice();

    if (counterPrice != null) {
      return Row(
        children: [
          _buildOldPrice(),
          const SizedBox(width: 12),
          _buildNewPrice(counterPrice),
        ],
      );
    }

    return _buildDefaultPrice();
  }

  Widget _buildOldPrice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.color1.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'ລາຄາເດີມ',
            style: TextStyle(
              color: AppColors.color1.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${NumberFormat().format(request.offeredPrice ?? 0)} ກີບ',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewPrice(double counterPrice) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.color1, AppColors.color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.color1.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'ລາຄາໃໝ່',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${NumberFormat().format(counterPrice)} ກີບ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultPrice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.color1, AppColors.color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.color1.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            '${NumberFormat().format(request.offeredPrice ?? 0)} ກີບ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  double? _getCounterPrice() {
    if (requestState != null && requestState!.startsWith('counter:')) {
      final parts = requestState!.split(':');
      if (parts.length > 1) {
        try {
          return double.tryParse(parts[1]);
        } catch (_) {}
      }
    }
    return null;
  }
}