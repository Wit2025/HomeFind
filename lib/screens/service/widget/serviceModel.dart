import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ServiceType {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  ServiceType({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class ServiceMarker {
  final String id;
  final LatLng position;
  final String name;
  final String type;
  final String phoneNumber;
  final String price;
  final String workingHours;
  final double rating;
  final String description;

  ServiceMarker(
    this.id,
    this.position,
    this.name,
    this.type, {
    required this.phoneNumber,
    required this.price,
    required this.workingHours,
    required this.rating,
    required this.description,
  });
}

class ServiceData {
  static final List<ServiceType> serviceTypes = [
    ServiceType(
      id: 'ac_repair',
      name: 'ຊ່າງຊ່ອມແອ',
      icon: Icons.ac_unit,
      color: Colors.white,
    ),
    ServiceType(
      id: 'electrician',
      name: 'ຊ່າງແລ່ນໄຟຟ້າ',
      icon: Icons.flash_on,
      color: Colors.white,
    ),
    ServiceType(
      id: 'mover',
      name: 'ຍ້າຍຂອງ',
      icon: Icons.local_shipping,
      color: Colors.white,
    ),
    ServiceType(
      id: 'furniture_repair',
      name: 'ຊ່າງເຟີນີເຈີ',
      icon: Icons.chair,
      color: Colors.white,
    ),
    ServiceType(
      id: 'mobile_repair',
      name: 'ຊ່າງແປງມືຖື',
      icon: Icons.phone_android,
      color: Colors.white,
    ),
    ServiceType(
      id: 'computer_repair',
      name: 'ຊ່າງແປງຄອມ',
      icon: Icons.computer,
      color: Colors.white,
    ),
    ServiceType(
      id: 'car_repair',
      name: 'ຊ່າງແປງລົດ',
      icon: Icons.car_repair,
      color: Colors.white,
    ),
    ServiceType(
      id: 'hairdresser',
      name: 'ຊ່າງຕັດຜົມ',
      icon: Icons.content_cut,
      color: Colors.white,
    ),
    ServiceType(
      id: 'builder',
      name: 'ຊ່າງກໍ່ສ້າງ',
      icon: Icons.construction,
      color: Colors.white,
    ),
    ServiceType(
      id: 'plumber',
      name: 'ຊ່າງຊ່ອງຫ້ອງນ້ຳ',
      icon: Icons.plumbing,
      color: Colors.white,
    ),
    ServiceType(
      id: 'painter',
      name: 'ຊ່າງທາສີ',
      icon: Icons.format_paint,
      color: Colors.white,
    ),
    ServiceType(
      id: 'locksmith',
      name: 'ຊ່າງກະແຈ',
      icon: Icons.vpn_key,
      color: Colors.white,
    ),
  ];

  static ServiceType getServiceType(String typeId) {
    return serviceTypes.firstWhere(
      (s) => s.id == typeId,
      orElse: () => ServiceType(
        id: 'unknown',
        name: 'Unknown',
        icon: Icons.help,
        color: Colors.grey,
      ),
    );
  }
}
