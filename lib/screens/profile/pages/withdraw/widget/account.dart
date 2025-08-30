import 'package:flutter/material.dart';

// Account model class
class Account {
  final String id;
  final String name;
  final String number;
  final IconData icon;

  Account({
    required this.id,
    required this.name,
    required this.number,
    required this.icon,
  });
}