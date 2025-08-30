// data/property_data.dart
import 'package:flutter/material.dart';
import 'package:homefind/screens/home/home_page/widget/property_model.dart';

class PropertyData {
  static final List<Map<String, String>> propertyList = [
    {
      'title': 'ຫ້ອງແຖວ 2 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ສີສັດຕະນາກ, ດົງປາລານ',
      'date': '4',
      'price': '250000',
      'views': '120',
      'image': 'assets/images/ap1.jpeg',
      'category': 'ຫ້ອງແຖວ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ແຊຫ້ອງ',
      'rental': 'ຕໍ່ເດືອນ',
      'currency': 'LAK',
    },
    {
      'title': 'ເຮືອນ 3 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1',
      'price': '2500000',
      'views': '276',
      'image': 'assets/images/ap2.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'currency': 'USD',
    },
    {
      'title': 'ອາພາດເມັ້ນ ທະເລສາບ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ສີສັດຕະນາກ, ດົງປາລານ',
      'date': '1',
      'price': '180000',
      'views': '120',
      'image': 'assets/images/ap3.jpeg',
      'category': 'ອາພາດເມັ້ນ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'rental': 'ຕໍ່ເດືອນ',
      'currency': 'THB',
    },
    {
      'title': 'ອາພາດເມັ້ນ ໃຈກາງເມືອງ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1',
      'price': '18000000',
      'views': '276',
      'image': 'assets/images/ap4.jpeg',
      'category': 'ອາພາດເມັ້ນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ແຊຫ້ອງ',
      'currency': 'CNY',
    },
    {
      'title': 'ເຮືອນ 4 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ໄຊເສດຖາ, ບ້ານໄຊທານີ',
      'date': '4',
      'price': '95000000',
      'views': '95',
      'image': 'assets/images/ap1.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'rental': 'ຕໍ່ປີ',
      'currency': 'LAK',
    },
    {
      'title': 'ເຮືອນ 3 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1',
      'price': '2500000',
      'views': '276',
      'image': 'assets/images/ap2.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'currency': 'USD',
    },
    {
      'title': 'ດີນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ສີສັດຕະນາກ, ດົງປາລານ',
      'date': '1',
      'price': '180000',
      'views': '120',
      'image': 'assets/images/ap3.jpeg',
      'category': 'ດີນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'currency': 'BTH',
    },
    {
      'title': 'ອາພາດເມັ້ນ ໃຈກາງເມືອງ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1',
      'price': '18000000',
      'views': '276',
      'image': 'assets/images/ap4.jpeg',
      'category': 'ອາພາດເມັ້ນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ແຊຫ້ອງ',
      'currency': 'YCN',
    },
    {
      'title': 'ເຮືອນ 5 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ໄຊເສດຖາ, ບ້ານໄຊທານີ',
      'date': '4',
      'price': '9500000',
      'views': '95',
      'image': 'assets/images/ap1.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'rental': 'ຕໍ່ປີ',
      'currency': 'LAK',
    },
  ];

  static final List<Category> categories = [
    Category(title: 'ທັງຫມົດ', icon: Icons.apps),
    Category(title: 'ເຮືອນ', icon: Icons.home),
    Category(title: 'ຫ້ອງແຖວ', icon: Icons.home_work),
    Category(title: 'ອາພາດເມັ້ນ', icon: Icons.apartment),
    Category(title: 'ດີນ', icon: Icons.landscape),
    Category(title: 'ແຊທີ່ພັກ', icon: Icons.castle),
    Category(title: 'ຕິດຕັ້ງແອ', icon: Icons.ac_unit),
    Category(title: 'ແກ່ເຄື່ອງ', icon: Icons.local_shipping),
    Category(title: 'ຕິດຕັ້ງແວ່ນ', icon: Icons.window),
    Category(title: 'ເຟີນີເຈີ້', icon: Icons.chair),
  ];

  // Property manipulation methods
  static List<Property> getProperties() {
    return propertyList.map((map) => Property.fromMap(map)).toList();
  }

  static List<Property> searchProperties(String query, List<Property> properties) {
    if (query.isEmpty) {
      return properties;
    }

    final lowerCaseQuery = query.toLowerCase();

    return properties.where((property) {
      return property.title.toLowerCase().contains(lowerCaseQuery) ||
          property.location.toLowerCase().contains(lowerCaseQuery) ||
          property.category.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  static List<Property> filterProperties(
    List<Property> properties, {
    String selectedCategory = "ທັງຫມົດ",
    String selectedStatus = "ເຊົ່າ",
    String? selectedPropertyType,
    String? selectedTime,
    String? selectedPrice,
  }) {
    List<Property> filtered = properties.where((property) {
      // Category filter
      bool categoryMatch =
          selectedCategory == "ທັງຫມົດ" || property.category == selectedCategory;

      // Status filter (rent/sale)
      bool statusMatch = property.status == selectedStatus;

      // Room sharing filter (only for rent)
      bool roomSharingMatch = true;
      if (selectedStatus == 'ເຊົ່າ' &&
          selectedPropertyType != null &&
          selectedPropertyType != 'ທັງໝົດ') {
        roomSharingMatch = property.roomSharing == selectedPropertyType;
      }

      return categoryMatch && statusMatch && roomSharingMatch;
    }).toList();

    // Apply sorting based on selected filters
    if (selectedTime != null && selectedTime != 'ທັງໝົດ') {
      if (selectedTime == 'ລ່າສຸດ') {
        filtered.sort((a, b) => a.dateAsInt.compareTo(b.dateAsInt));
      } else if (selectedTime == 'ດົນສຸດ') {
        filtered.sort((a, b) => b.dateAsInt.compareTo(a.dateAsInt));
      }
    }

    if (selectedPrice != null && selectedPrice != 'ທັງໝົດ') {
      if (selectedPrice == 'ຖືກສຸດ') {
        filtered.sort((a, b) => a.priceAsDouble.compareTo(b.priceAsDouble));
      } else if (selectedPrice == 'ແພງສຸດ') {
        filtered.sort((a, b) => b.priceAsDouble.compareTo(a.priceAsDouble));
      }
    }

    return filtered;
  }
}