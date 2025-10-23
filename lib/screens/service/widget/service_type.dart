import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceType {
  final IconData icon;
  final String label;
  final String type;

  ServiceType({required this.icon, required this.label, required this.type});

  static List<ServiceType> get defaultServices => [
    ServiceType(
      icon: Icons.electrical_services,
      label: 'ໄຟຟ້າ',
      type: 'electrical',
    ),
    ServiceType(icon: Icons.computer, label: 'ຄອມພິວເຕີ', type: 'computer'),
    ServiceType(icon: Icons.phone_android, label: 'ມືຖື', type: 'mobile'),
    ServiceType(icon: Icons.plumbing, label: 'ປະປາ', type: 'plumbing'),
    ServiceType(icon: Icons.ac_unit, label: 'ແອ', type: 'ac'),
    ServiceType(icon: Icons.tv, label: 'ທີວີ', type: 'tv'),
    ServiceType(
      icon: FontAwesomeIcons.scissors,
      label: 'ຕັດຜົມ',
      type: 'abrber',
    ),
    ServiceType(
      icon: Icons.kitchen,
      label: 'ເຄື່ອງໃຊ້ໄຟຟ້າ',
      type: 'appliance',
    ),
    ServiceType(icon: Icons.build, label: 'ອື່ນໆ', type: 'other'),
  ];
}