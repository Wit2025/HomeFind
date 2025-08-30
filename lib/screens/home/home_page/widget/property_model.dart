// models/property_model.dart
import 'package:flutter/material.dart';

class Property {
  final String title;
  final String location;
  final String date;
  final String price;
  final String views;
  final String image;
  final String category;
  final String status;
  final String? roomSharing;
  final String? rental;
  final String? currency;

  Property({
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    required this.views,
    required this.image,
    required this.category,
    required this.status,
    this.roomSharing,
    this.rental,
    this.currency,
  });

  // Convert from Map to Property
  factory Property.fromMap(Map<String, String> map) {
    return Property(
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      date: map['date'] ?? '',
      price: map['price'] ?? '',
      views: map['views'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
      status: map['status'] ?? '',
      roomSharing: map['roomSharing'],
      rental: map['rental'],
      currency: map['currency'],
    );
  }

  // Convert from Property to Map
  Map<String, String> toMap() {
    return {
      'title': title,
      'location': location,
      'date': date,
      'price': price,
      'views': views,
      'image': image,
      'category': category,
      'status': status,
      if (roomSharing != null) 'roomSharing': roomSharing!,
      if (rental != null) 'rental': rental!,
      if (currency != null) 'currency': currency!,
    };
  }

  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  int get dateAsInt => int.tryParse(date) ?? 0;
  int get viewsAsInt => int.tryParse(views) ?? 0;
}

class Category {
  final String title;
  final IconData icon;

  Category({
    required this.title,
    required this.icon,
  });
}