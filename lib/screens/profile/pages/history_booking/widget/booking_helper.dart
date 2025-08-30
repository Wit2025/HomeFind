import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class BookingHelper {
  static Color getStatusColor(String status) {
    switch (status) {
      case 'ສຳເລັດ':
        return Colors.green;
      case 'ລໍຖ້າຢືນຢັນ':
        return Colors.orange;
      case 'ຍົກເລີກ':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static Color getTypeColor(String? type) {
    switch (type) {
      case 'ເຊົ່າ':
        return const Color(0xFF006B8B);
      case 'ຂາຍ':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static String getLocalizedStatus(String status, S l10n) {
    switch (status) {
      case 'ສຳເລັດ':
        return l10n.completed;
      case 'ລໍຖ້າຢືນຢັນ':
        return l10n.pending;
      case 'ຍົກເລີກ':
        return l10n.cancelled;
      default:
        return status;
    }
  }

  static String getLocalizedType(String type, S l10n) {
    switch (type) {
      case 'ເຊົ່າ':
        return l10n.rent;
      case 'ຂາຍ':
        return l10n.sale;
      default:
        return type;
    }
  }

  static List<Map<String, String>> filterBookings(
    List<Map<String, String>> bookings,
    String? selectedStatusFilter,
    String? selectedTypeFilter,
  ) {
    return bookings.where((booking) {
      final statusMatch = selectedStatusFilter == null ||
          selectedStatusFilter == 'ທັງໝົດ' ||
          booking['status'] == selectedStatusFilter;
      final typeMatch = selectedTypeFilter == null ||
          selectedTypeFilter == 'ທັງໝົດ' ||
          booking['type'] == selectedTypeFilter;
      return statusMatch && typeMatch;
    }).toList();
  }
}