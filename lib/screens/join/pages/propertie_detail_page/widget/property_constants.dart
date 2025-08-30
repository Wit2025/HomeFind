// utils/property_constants.dart
import 'package:flutter/material.dart';

class PropertyConstants {
  // Categories data
  static final List<Map<String, dynamic>> categories = [
    {'title': 'ເຮືອນ', 'icon': Icons.home},
    {'title': 'ຫ້ອງແຖວ', 'icon': Icons.home_work},
    {'title': 'ອາພາດເມັ້ນ', 'icon': Icons.apartment},
    {'title': 'ດິນ', 'icon': Icons.landscape},
    {'title': 'ແຊທີ່ພັກ', 'icon': Icons.castle},
    {'title': 'ຕິດຕັ້ງແອ', 'icon': Icons.ac_unit},
    {'title': 'ແກ່ເຄື່ອງ', 'icon': Icons.local_shipping},
    {'title': 'ຕິດຕັ້ງແວ່ນ', 'icon': Icons.window},
    {'title': 'ເຟີນີເຈີ້', 'icon': Icons.chair},
  ];

  // Amenity icons
  static IconData getAmenityIcon(String amenity) {
    switch (amenity) {
      case 'ຈອດລົດ':
        return Icons.local_parking_outlined;
      case 'ອິນເຕີເນັດ':
        return Icons.wifi;
      case 'ເຄື່ອງເຮືອນ':
        return Icons.chair_outlined;
      case 'ສະລອຍນໍ້າ':
        return Icons.pool_outlined;
      case 'ຕູ້ເຢັນ':
        return Icons.kitchen_outlined;
      case 'ກວດຄົນເຂົ້າ':
        return Icons.security_outlined;
      case 'ແອ':
        return Icons.ac_unit_outlined;
      case 'ເຄື່ອງຊັກຜ້າ':
        return Icons.local_laundry_service_outlined;
      default:
        return Icons.check_outlined;
    }
  }
}