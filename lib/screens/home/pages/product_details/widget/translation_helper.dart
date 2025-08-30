import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class TranslationHelper {
  static String translateCategory(String category, BuildContext context) {
    switch (category) {
      case 'ທັງຫມົດ':
        return S.of(context).all;
      case 'ເຮືອນ':
        return S.of(context).house;
      case 'ຫ້ອງແຖວ':
        return S.of(context).townhouse;
      case 'ອາພາດເມັ້ນ':
        return S.of(context).apartment;
      case 'ດີນ':
        return S.of(context).land;
      case 'ແຊທີ່ພັກ':
        return S.of(context).accommodation_zone;
      case 'ຕິດຕັ້ງແອ':
        return S.of(context).install_air;
      case 'ແກ່ເຄື່ອງ':
        return S.of(context).moving_goods;
      case 'ຕິດຕັ້ງແວ່ນ':
        return S.of(context).install_glass;
      case 'ເຟີນີເຈີ້':
        return S.of(context).furniture;
      default:
        return category;
    }
  }

  static String translateStatus(String status, BuildContext context) {
    switch (status) {
      case 'ເຊົ່າ':
        return S.of(context).rent;
      case 'ຂາຍ':
        return S.of(context).sale;
      default:
        return status;
    }
  }

  static String translateRental(String rental, BuildContext context) {
    switch (rental) {
      case 'ຕໍ່ປີ':
        return S.of(context).per_y;
      case 'ຕໍ່ເດືອນ':
        return S.of(context).per_m;
      default:
        return rental;
    }
  }
}