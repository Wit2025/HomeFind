import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:homefind/screens/service/widget/serviceDetailSheet.dart';
import 'package:homefind/screens/service/widget/serviceList.dart';
import 'package:homefind/screens/service/widget/serviceMap.dart';
import 'package:homefind/screens/service/widget/serviceModel.dart';
import 'package:homefind/screens/service/widget/searchBarSection.dart';
import 'package:latlong2/latlong.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<ServiceMarker> _allMarkers = [];
  List<ServiceMarker> _filteredMarkers = [];
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  // ตำแหน่งเริ่มต้น (เวียงจันทน์, ลาว)
  final LatLng _kVientiane = LatLng(17.981442, 102.618952);

  String? _selectedServiceType;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadMarkers() {
    List<ServiceMarker> markers = [
      ServiceMarker(
        'ac_1',
        LatLng(17.9657, 102.6131),
        'ຊ່າງຊ່ອມແອ ບ້ານດົງໂດກ',
        'ac_repair',
        phoneNumber: '020 5555 1234',
        price: '50,000-150,000 ກີບ',
        workingHours: '08:00-18:00',
        rating: 4.5,
        description: 'ຊ່ອມແອທຸກຊະນິດ, ບໍລິການດີ, ລາຄາຖືກ',
      ),
      ServiceMarker(
        'ac_2',
        LatLng(17.9757, 102.6231),
        'ຊ່າງຊ່ອມແອ ບ້ານສີໂຄດຕະບອງ',
        'ac_repair',
        phoneNumber: '020 5555 1235',
        price: '60,000-200,000 ກີບ',
        workingHours: '07:00-19:00',
        rating: 4.8,
        description: 'ມີປະສົບການ 10 ປີ, ມີໃບປະກາດ',
      ),
      ServiceMarker(
        'electric_1',
        LatLng(17.9857, 102.6331),
        'ຊ່າງໄຟຟ້າ ບ້ານສີເມືອງ',
        'electrician',
        phoneNumber: '020 5555 2234',
        price: '30,000-100,000 ກີບ',
        workingHours: '08:00-20:00',
        rating: 4.6,
        description: 'ຊ່ອມໄຟຟ້າ, ຕິດຕັ້ງໄຟໃຫມ່, ບໍລິການດ່ວນ 24 ຊົ່ວໂມງ',
      ),
      ServiceMarker(
        'electric_2',
        LatLng(17.9957, 102.6431),
        'ຊ່າງໄຟຟ້າ ບ້ານທົ່ງພະເຈົ້າ',
        'electrician',
        phoneNumber: '020 5555 2235',
        price: '40,000-120,000 ກີບ',
        workingHours: '07:00-19:00',
        rating: 4.3,
        description: 'ຊ່ຽວຊານໄຟຟ້າບ້ານ ແລະ ໂຮງງານ',
      ),
      ServiceMarker(
        'mover_1',
        LatLng(17.9557, 102.6231),
        'ຍ້າຍຂອງ ບ້ານໂນນວັນ',
        'mover',
        phoneNumber: '020 5555 3234',
        price: '200,000-1,000,000 ກີບ',
        workingHours: '06:00-20:00',
        rating: 4.7,
        description: 'ມີລົດຂະໜາດໃຫຍ່, ຍ້າຍຂອງລະມັດລະວັງ',
      ),
      ServiceMarker(
        'mover_2',
        LatLng(17.9457, 102.6331),
        'ຍ້າຍຂອງ ບ້ານດົງດາ',
        'mover',
        phoneNumber: '020 5555 3235',
        price: '150,000-800,000 ກີບ',
        workingHours: '07:00-19:00',
        rating: 4.4,
        description: 'ບໍລິການຍ້າຍຂອງທົ່ວ ນະຄອນຫຼວງວຽງຈັນ',
      ),
      ServiceMarker(
        'furniture_1',
        LatLng(17.9657, 102.6531),
        'ຊ່າງເຟີນີເຈີ ບ້ານເຊົ້າຟ້າ',
        'furniture_repair',
        phoneNumber: '020 5555 4234',
        price: '40,000-300,000 ກີບ',
        workingHours: '08:00-18:00',
        rating: 4.9,
        description: 'ຊ່ອມເຟີນີເຈີ, ສ້າງໃຫມ່, ດັດແປງ',
      ),
      ServiceMarker(
        'furniture_2',
        LatLng(17.9757, 102.6631),
        'ຊ່າງເຟີນີເຈີ ບ້ານຫົວຂົວ',
        'furniture_repair',
        phoneNumber: '020 5555 4235',
        price: '50,000-350,000 ກີບ',
        workingHours: '07:30-17:30',
        rating: 4.5,
        description: 'ຊ່າງມືອາຊີບ, ງານລະອຽດ',
      ),
      ServiceMarker(
        'mobile_1',
        LatLng(17.9857, 102.6031),
        'ຊ່າງແປງມືຖື ຕະຫຼາດເຊົ້າ',
        'mobile_repair',
        phoneNumber: '020 5555 5234',
        price: '20,000-500,000 ກີບ',
        workingHours: '08:00-20:00',
        rating: 4.6,
        description: 'ແປງມືຖືທຸກຍີ່ຫໍ້, ມີອາໄຫຼ່ພ້ອມ',
      ),
      ServiceMarker(
        'mobile_2',
        LatLng(17.9957, 102.6131),
        'ຊ່າງແປງມືຖື ມໍລ໌ວຽງຈັນ',
        'mobile_repair',
        phoneNumber: '020 5555 5235',
        price: '30,000-600,000 ກີບ',
        workingHours: '09:00-21:00',
        rating: 4.8,
        description: 'ຮັບປະກັນ 3 ເດືອນ, ແປງດ່ວນພາຍໃນວັນ',
      ),
      ServiceMarker(
        'computer_1',
        LatLng(17.9657, 102.6231),
        'ຊ່າງແປງຄອມ ບ້ານດົງປ່າຍາງ',
        'computer_repair',
        phoneNumber: '020 5555 6234',
        price: '50,000-800,000 ກີບ',
        workingHours: '08:30-19:00',
        rating: 4.7,
        description: 'ຊ່ອມຄອມ, ໂນດບຸກ, ຕິດຕັ້ງໂປຣແກຣມ',
      ),
      ServiceMarker(
        'computer_2',
        LatLng(17.9757, 102.6331),
        'ຊ່າງແປງຄອມ ບ້ານສີໂຄດຕະບອງ',
        'computer_repair',
        phoneNumber: '020 5555 6235',
        price: '40,000-700,000 ກີບ',
        workingHours: '08:00-18:00',
        rating: 4.4,
        description: 'ບໍລິການຖິ່ມທີ່, ມີການຮັບປະກັນ',
      ),
      ServiceMarker(
        'car_1',
        LatLng(17.9557, 102.6131),
        'ຊ່າງແປງລົດ ບ້ານດົງໂດກ',
        'car_repair',
        phoneNumber: '020 5555 7234',
        price: '100,000-2,000,000 ກີບ',
        workingHours: '07:00-19:00',
        rating: 4.8,
        description: 'ອູ່ລົດໃຫຍ່, ມີເຄື່ອງມືຄົບຄົວ',
      ),
      ServiceMarker(
        'car_2',
        LatLng(17.9457, 102.6531),
        'ຊ່າງແປງລົດ ບ້ານສີດອນຈັນ',
        'car_repair',
        phoneNumber: '020 5555 7235',
        price: '80,000-1,800,000 ກີບ',
        workingHours: '06:30-18:30',
        rating: 4.5,
        description: 'ຊ່ອມລົດທຸກຊະນິດ, ລາຄາຍຸດຕິທຳ',
      ),
      ServiceMarker(
        'hair_1',
        LatLng(17.9757, 102.6431),
        'ຊ່າງຕັດຜົມ ຕະຫຼາດປາ',
        'hairdresser',
        phoneNumber: '020 5555 8234',
        price: '20,000-150,000 ກີບ',
        workingHours: '08:00-20:00',
        rating: 4.9,
        description: 'ຊ່າງມືອາຊີບ, ຕັດ ຍ້ອມ ຟອກ',
      ),
      ServiceMarker(
        'hair_2',
        LatLng(17.9857, 102.6531),
        'ຊ່າງຕັດຜົມ ມໍລ໌ໃໝ່',
        'hairdresser',
        phoneNumber: '020 5555 8235',
        price: '25,000-200,000 ກີບ',
        workingHours: '09:00-21:00',
        rating: 4.7,
        description: 'ສະໄຕລ໌ທັນສະໄໝ, ບັດສະເພາະ',
      ),
      ServiceMarker(
        'builder_1',
        LatLng(17.9657, 102.6031),
        'ຊ່າງກໍ່ສ້າງ ບ້ານເຊົ້າຟ້າ',
        'builder',
        phoneNumber: '020 5555 9234',
        price: '500,000-10,000,000 ກີບ',
        workingHours: '06:00-18:00',
        rating: 4.6,
        description: 'ສ້າງບ້ານ, ກໍ່ຕໍ່ເຕີມ, ປັບປຸງ',
      ),
      ServiceMarker(
        'builder_2',
        LatLng(17.9757, 102.6131),
        'ຊ່າງກໍ່ສ້າງ ບ້ານເສົາທອງ',
        'builder',
        phoneNumber: '020 5555 9235',
        price: '600,000-12,000,000 ກີບ',
        workingHours: '06:00-17:00',
        rating: 4.8,
        description: 'ທີມງານຊ່າງມືອາຊີບ, ມີໃບຢັ້ງຢືນ',
      ),
      ServiceMarker(
        'plumber_1',
        LatLng(17.9857, 102.6231),
        'ຊ່າງຊ່ອມຫ້ອງນ້ຳ ບ້ານສີໂຄດຕະບອງ',
        'plumber',
        phoneNumber: '020 5555 0234',
        price: '40,000-300,000 ກີບ',
        workingHours: '08:00-19:00',
        rating: 4.5,
        description: 'ຊ່ອມທໍ່ນ້ຳ, ຫ້ອງນ້ຳ, ອ່າງລ້າງ',
      ),
      ServiceMarker(
        'plumber_2',
        LatLng(17.9957, 102.6331),
        'ຊ່າງຊ່ອມຫ້ອງນ້ຳ ບ້ານຫົວຂົວ',
        'plumber',
        phoneNumber: '020 5555 0235',
        price: '35,000-280,000 ກີບ',
        workingHours: '07:00-18:00',
        rating: 4.4,
        description: 'ບໍລິການດ່ວນ, ແກ້ໄຂຂຸດຂໍ້ທຸກສະຖານະການ',
      ),
      ServiceMarker(
        'painter_1',
        LatLng(17.9557, 102.6431),
        'ຊ່າງທາສີ ບ້ານໂນນວັນ',
        'painter',
        phoneNumber: '020 5555 1111',
        price: '80,000-500,000 ກີບ',
        workingHours: '07:00-17:00',
        rating: 4.7,
        description: 'ທາສີບ້ານ, ຫ້ອງການ, ຮັບປະກັນສິນ',
      ),
      ServiceMarker(
        'painter_2',
        LatLng(17.9457, 102.6531),
        'ຊ່າງທາສີ ບ້ານດົງໂດກ',
        'painter',
        phoneNumber: '020 5555 1112',
        price: '70,000-450,000 ກີບ',
        workingHours: '06:30-17:30',
        rating: 4.6,
        description: 'ມີສີທຸກສີ, ໃຊ້ສີຄຸນນະພາບດີ',
      ),
      ServiceMarker(
        'locksmith_1',
        LatLng(17.9757, 102.6631),
        'ຊ່າງກະແຈ ບ້ານສີເມືອງ',
        'locksmith',
        phoneNumber: '020 5555 2222',
        price: '30,000-200,000 ກີບ',
        workingHours: '08:00-20:00',
        rating: 4.8,
        description: 'ເປີດປະຕູຕູ້ໄດ, ເຮັດກະແຈໃຫມ່',
      ),
      ServiceMarker(
        'locksmith_2',
        LatLng(17.9857, 102.6031),
        'ຊ່າງກະແຈ ຕະຫຼາດເຊົ້າ',
        'locksmith',
        phoneNumber: '020 5555 2223',
        price: '25,000-180,000 ກີບ',
        workingHours: '07:30-19:30',
        rating: 4.5,
        description: 'ບໍລິການດ່ວນ 24 ຊົ່ວໂມງ',
      ),
    ];

    setState(() {
      _allMarkers = markers;
      _filteredMarkers = markers;
    });
  }

  void _filterMarkers(String? serviceType) {
    setState(() {
      _selectedServiceType = serviceType;
      String searchText = _searchController.text.toLowerCase();

      if (serviceType == null) {
        _filteredMarkers = searchText.isEmpty
            ? _allMarkers
            : _allMarkers
                  .where((m) => m.name.toLowerCase().contains(searchText))
                  .toList();
      } else {
        var filtered = _allMarkers
            .where((marker) => marker.type == serviceType)
            .toList();
        _filteredMarkers = searchText.isEmpty
            ? filtered
            : filtered
                  .where((m) => m.name.toLowerCase().contains(searchText))
                  .toList();
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      String searchText = value.toLowerCase();
      if (searchText.isEmpty) {
        _filteredMarkers = _selectedServiceType == null
            ? _allMarkers
            : _allMarkers.where((m) => m.type == _selectedServiceType).toList();
      } else {
        var filtered = _selectedServiceType == null
            ? _allMarkers
            : _allMarkers.where((m) => m.type == _selectedServiceType).toList();
        _filteredMarkers = filtered
            .where((m) => m.name.toLowerCase().contains(searchText))
            .toList();
      }
    });
  }

  void _showServiceDetails(ServiceMarker marker) {
    ServiceDetailsSheet.show(
      context: context,
      marker: marker,
      mapController: _mapController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // แผนที่
          ServiceMap(mapController: _mapController, initialCenter: _kVientiane),

          // ช่องค้นหา
          Positioned(
            top: MediaQuery.of(context).padding.top + (-40),
            left: 16,
            right: 16,
            child: SearchBarSection(
              searchController: _searchController,
              onSearchChanged: _onSearchChanged,
            ),
          ),

          // รายการบริการด้านล่าง
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: ServiceList(
              filteredMarkers: _filteredMarkers,
              selectedServiceType: _selectedServiceType,
              onServiceTap: _showServiceDetails,
              onClearFilter: () => _filterMarkers(null),
            ),
          ),
        ],
      ),
    );
  }
}
