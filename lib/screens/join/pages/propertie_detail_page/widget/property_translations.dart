// utils/property_translations.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class PropertyTranslations {
  static String translateValue(String value, BuildContext context) {
    switch (value) {
      case 'ເຊົ່າ':
        return S.of(context).rent;
      case 'ຂາຍ':
        return S.of(context).sale;
      case 'ເຮືອນ':
        return S.of(context).house;
      case 'ຫ້ອງແຖວ':
        return S.of(context).townhouse;
      case 'ອາພາດເມັ້ນ':
        return S.of(context).apartment;
      case 'ດິນ':
        return S.of(context).land;
      case 'ແຊທີ່ພັກ':
        return S.of(context).room_sharing;
      case 'ຕິດຕັ້ງແອ':
        return S.of(context).install_air;
      case 'ແກ່ເຄື່ອງ':
        return S.of(context).moving_goods;
      case 'ຕິດຕັ້ງແວ່ນ':
        return S.of(context).install_glass;
      case 'ເຟີນີເຈີ້':
        return S.of(context).furniture;
      case 'ແຊຫ້ອງ':
        return S.of(context).share_room;
      case 'ບໍ່ແຊຫ້ອງ':
        return S.of(context).no_share_room;
      case 'ເປັນເດືອນ':
        return S.of(context).per_month;
      case 'ເປັນປີ':
        return S.of(context).perYear;
      case 'ຈອດລົດ':
        return S.of(context).parking;
      case 'ອິນເຕີເນັດ':
        return S.of(context).internet;
      case 'ເຄື່ອງເຮືອນ':
        return S.of(context).furniture;
      case 'ສະລອຍນໍ້າ':
        return S.of(context).swimmingPool;
      case 'ຕູ້ເຢັນ':
        return S.of(context).refrigerator;
      case 'ກວດຄົນເຂົ້າ':
        return S.of(context).security_check;
      case 'ແອ':
        return S.of(context).air;
      case 'ເຄື່ອງຊັກຜ້າ':
        return S.of(context).washing_machine;
      default:
        return value;
    }
  }
}