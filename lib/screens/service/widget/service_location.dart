class ServiceLocation {
  final String id;
  final String title;
  final String address;
  final double lat;
  final double lng;

  ServiceLocation({
    required this.id,
    required this.title,
    required this.address,
    required this.lat,
    required this.lng,
  });

  static List<ServiceLocation> sampleLocations() {
    return [
      ServiceLocation(
        id: 'loc_1',
        title: 'ບ້ານ ສີວິໄລ',
        address: 'ຖະໜົນ 123, ເມືອງ ໄຊທານີ, ນະຄອນຫຼວງວຽງຈັນ',
        lat: 17.9657,
        lng: 102.6131,
      ),
      ServiceLocation(
        id: 'loc_2',
        title: 'ບ້ານ ສາຍລົມ',
        address: 'ຖະໜົນ 45, ເມືອງ ຈັນທະບູລີ, ນະຄອນຫຼວງວຽງຈັນ',
        lat: 17.9757,
        lng: 102.6231,
      ),
      ServiceLocation(
        id: 'loc_3',
        title: 'ບ້ານ ສີເມືອງ',
        address: 'ຖະໜົນ 78, ເມືອງ ໄຊທານີ, ນະຄອນຫຼວງວຽງຈັນ',
        lat: 17.9857,
        lng: 102.6331,
      ),
      ServiceLocation(
        id: 'loc_4',
        title: 'ບ້ານ ໜອງວຽງຄຳ',
        address: 'ຖະໜົນ 9, ເມືອງ ໄຊທານີ, ນະຄອນຫຼວງວຽງຈັນ',
        lat: 17.9920,
        lng: 102.6400,
      ),
      ServiceLocation(
        id: 'loc_5',
        title: 'ບ້ານ ຕານມີໄຊ',
        address: 'ຖະໜົນ 56, ເມືອງ ໄຊທານີ, ນະຄອນຫຼວງວຽງຈັນ',
        lat: 17.9700,
        lng: 102.6100,
      ),
      ServiceLocation(
        id: 'loc_6',
        title: 'ບ້ານ ສີສະຫວາດ',
        address: 'ຖະໜົນ 1, ເມືອງ ຈັນທະບູລີ, ນະຄອນຫຼວງວຽງຈັນ',
        lat: 17.9800,
        lng: 102.6200,
      ),
    ];
  }
}
