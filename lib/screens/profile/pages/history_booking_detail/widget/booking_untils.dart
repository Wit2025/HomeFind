import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'booking_constants.dart';

class BookingUtils {
  /// แปลง status เป็นข้อความที่แสดงผล
  static String getStatusDisplayText(BuildContext context, String status) {
    switch (status) {
      case BookingStatus.completed:
        return S.of(context).completed;
      case BookingStatus.pending:
        return S.of(context).pending;
      case BookingStatus.cancelled:
        return S.of(context).cancelled;
      default:
        return status;
    }
  }

  /// แปลง type เป็นข้อความที่แสดงผล
  static String getTypeDisplayText(BuildContext context, String type) {
    switch (type) {
      case BookingType.rental:
        return S.of(context).rent;
      case BookingType.sale:
        return S.of(context).sale;
      default:
        return type;
    }
  }

  /// กำหนดสีพื้นหลังของ status
  static Color getStatusBackgroundColor(String status) {
    switch (status) {
      case BookingStatus.completed:
        return Colors.green.shade100;
      case BookingStatus.pending:
        return Colors.orange.shade100;
      case BookingStatus.cancelled:
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  /// กำหนดสีขอบของ status
  static Color getStatusBorderColor(String status) {
    switch (status) {
      case BookingStatus.completed:
        return Colors.green.shade300;
      case BookingStatus.pending:
        return Colors.orange.shade300;
      case BookingStatus.cancelled:
        return Colors.red.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  /// กำหนดสีตัวหนังสือของ status
  static Color getStatusTextColor(String status) {
    switch (status) {
      case BookingStatus.completed:
        return Colors.green.shade700;
      case BookingStatus.pending:
        return Colors.orange.shade700;
      case BookingStatus.cancelled:
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  /// กำหนดสีพื้นหลังของ type
  static Color getTypeBackgroundColor(String type) {
    switch (type) {
      case BookingType.rental:
        return Colors.blue.shade50;
      case BookingType.sale:
        return Colors.red.shade50;
      default:
        return Colors.grey.shade50;
    }
  }

  /// กำหนดสีตัวหนังสือของ type
  static Color getTypeTextColor(String type) {
    switch (type) {
      case BookingType.rental:
        return Colors.blue.shade700;
      case BookingType.sale:
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  /// รายการรูปภาพโรงแรม
  static List<String> getHotelImages(String? primaryImage) {
    return [
      primaryImage ?? 'assets/images/default.jpg',
      "assets/images/b1.jpg",
      "assets/images/b2.jpg",
      "assets/images/b3.jpg",
      "assets/images/b4.jpg",
      "assets/images/b5.jpg",
      "assets/images/b6.jpg",
      "assets/images/b7.jpg",
      "assets/images/b8.jpg",
      "assets/images/b9.jpg",
      "assets/images/b10.jpg",
    ];
  }
}