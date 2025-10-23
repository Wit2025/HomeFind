import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'booking_helper.dart';

class BookingCardWidget extends StatelessWidget {
  final Map<String, String> booking;
  final S l10n;
  final VoidCallback onTap;

  const BookingCardWidget({
    super.key,
    required this.booking,
    required this.l10n,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Column(children: [_buildImage(), _buildContent()]),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Image.asset(
        booking['image']!,
        width: double.infinity,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleAndStatus(),
            const SizedBox(height: 4),
            _buildLocation(),
            const SizedBox(height: 4),
            _buildDate(),
            const SizedBox(height: 4),
            _buildPriceAndType(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            booking['title']!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: BookingHelper.getStatusColor(
              booking['status']!,
            ).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: BookingHelper.getStatusColor(booking['status']!),
              width: 1,
            ),
          ),
          child: Text(
            BookingHelper.getLocalizedStatus(booking['status']!, l10n),
            style: TextStyle(
              fontSize: 10,
              color: BookingHelper.getStatusColor(booking['status']!),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            booking['location']!,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDate() {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          booking['date']!,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPriceAndType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '₭ ${booking['price'] ?? ''}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006B8B),
          ),
        ),
        if (booking['type'] != null) _buildTypeLabel(),
      ],
    );
  }

  Widget _buildTypeLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: BookingHelper.getTypeColor(
          booking['type'],
        ).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: BookingHelper.getTypeColor(booking['type']),
          width: 1,
        ),
      ),
      child: Text(
        BookingHelper.getLocalizedType(booking['type']!, l10n),
        style: TextStyle(
          fontSize: 10,
          color: BookingHelper.getTypeColor(booking['type']),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
