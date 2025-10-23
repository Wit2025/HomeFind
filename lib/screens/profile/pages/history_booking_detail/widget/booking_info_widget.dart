import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/widget/booking_untils.dart';
import 'booking_constants.dart';

class BookingInfoWidget extends StatelessWidget {
  final Map<String, String> booking;

  const BookingInfoWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final status = booking['status'] ?? BookingStatus.pending;
    final type = booking['type'] ?? BookingType.rental;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  booking['title'] ?? '',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: BookingUtils.getStatusBackgroundColor(status),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: BookingUtils.getStatusBorderColor(status),
                  ),
                ),
                child: Text(
                  BookingUtils.getStatusDisplayText(context, status),
                  style: TextStyle(
                    fontSize: 14,
                    color: BookingUtils.getStatusTextColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),

          // Type and Rating
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: BookingUtils.getTypeBackgroundColor(type),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${S.of(context).bookingType}: ${BookingUtils.getTypeDisplayText(context, type)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: BookingUtils.getTypeTextColor(type),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(Icons.star, color: Colors.amber, size: 18),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '4.8',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Location
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.location_on, color: Colors.red, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    booking['location'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          // Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Text(
                    booking['date'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),

          // Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).details,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                S.of(context).breakfast_review,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
