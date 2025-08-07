import 'package:flutter/material.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail.dart';

class HistoryBookingPages extends StatefulWidget {
  const HistoryBookingPages({super.key});

  @override
  State<HistoryBookingPages> createState() => _HistoryBookingPagesState();
}

class _HistoryBookingPagesState extends State<HistoryBookingPages> {
  final List<Map<String, String>> allBookings = [
    {
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ເວຽງຈັນ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ຍົກເລີກ',
      'type': 'ເຊົ່າ',
    },
    {
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'assets/images/house.jpg',
      'price': '75,000 ກີບ',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'assets/images/house.jpg',
      'price': '60,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ເຊົ່າ',
    },
    {
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ເວຽງຈັນ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ເຊົ່າ',
    },
    {
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ຍົກເລີກ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'assets/images/house.jpg',
      'price': '75,000 ກີບ',
      'status': 'ສຳເລັດ',
      'type': 'ເຊົ່າ',
    },
    {
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'assets/images/house.jpg',
      'price': '60,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ເວຽງຈັນ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ສຳເລັດ',
      'type': 'ເຊົ່າ',
    },
    {
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'assets/images/house.jpg',
      'price': '50,000 ກີບ',
      'status': 'ຍົກເລີກ',
      'type': 'ເຊົ່າ',
    },
    {
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'assets/images/house.jpg',
      'price': '75,000 ກີບ',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'assets/images/house.jpg',
      'price': '60,000 ກີບ',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ເຊົ່າ',
    },
  ];

  String? _selectedStatusFilter;
  String? _selectedTypeFilter;

  @override
  void initState() {
    super.initState();
    _selectedTypeFilter = 'ເຊົ່າ';
  }

  List<Map<String, String>> get _filteredBookings {
    return allBookings.where((booking) {
      final statusMatch =
          _selectedStatusFilter == null ||
          _selectedStatusFilter == 'ທັງໝົດ' ||
          booking['status'] == _selectedStatusFilter;
      final typeMatch =
          _selectedTypeFilter == null ||
          _selectedTypeFilter == 'ທັງໝົດ' ||
          booking['type'] == _selectedTypeFilter;
      return statusMatch && typeMatch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ສຳເລັດ':
        return Colors.green;
      case 'ລໍຖ້າຢືນຢັນ':
        return Colors.orange;
      case 'ຍົກເລີກ':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case 'ເຊົ່າ':
        return Color(0xFF006B8B);
      case 'ຂາຍ':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 87, 167, 177),
                Color.fromARGB(255, 12, 105, 122),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'ປະຫວັດການຈອງ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Status Filter buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatusFilterButton('ທັງໝົດ', null),
                  const SizedBox(width: 8),
                  _buildStatusFilterButton('ສຳເລັດ', 'ສຳເລັດ'),
                  const SizedBox(width: 8),
                  _buildStatusFilterButton('ລໍຖ້າ', 'ລໍຖ້າຢືນຢັນ'),
                  const SizedBox(width: 8),
                  _buildStatusFilterButton('ຍົກເລີກ', 'ຍົກເລີກ'),
                  const SizedBox(width: 8),
                  Container(
                    height: 32, // Match the height of your filter buttons
                    constraints: const BoxConstraints(minWidth: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Match button radius
                      color: const Color(0xFF006B8B),
                      border: Border.all(
                        color: _selectedTypeFilter == null
                            ? Colors.grey
                            : const Color(0xFF006B8B),
                        width: 0.6,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButton<String>(
                      value: _selectedTypeFilter,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: _selectedTypeFilter == null
                            ? Colors.black
                            : Colors.white,
                        size: 20,
                      ),
                      elevation: 16,
                      style: TextStyle(
                        color: _selectedTypeFilter == null
                            ? Colors.black
                            : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(12),
                      dropdownColor: Colors.white,
                      items: <String>['ທັງໝົດ', 'ເຊົ່າ', 'ຂາຍ']
                          .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value == 'ທັງໝົດ' ? null : value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          })
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTypeFilter = newValue;
                        });
                      },
                      isDense: true, // Makes the dropdown more compact
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Booking list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: _filteredBookings.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final booking = _filteredBookings[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookingDetailPage(booking: booking),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 1,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  booking['image']!,
                                  width: double.infinity,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              booking['title']!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(
                                                booking['status']!,
                                              ).withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: _getStatusColor(
                                                  booking['status']!,
                                                ),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              booking['status']!,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getStatusColor(
                                                  booking['status']!,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              booking['location']!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            booking['date']!,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            booking['price'] ?? '',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF006B8B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Type badge (bottom-right of card)
                          if (booking['type'] != null)
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getTypeColor(
                                    booking['type'],
                                  ).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getTypeColor(booking['type']),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  booking['type']!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getTypeColor(booking['type']),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilterButton(String label, String? status) {
    final isSelected = _selectedStatusFilter == status;
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedStatusFilter = status;
        });
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: isSelected ? null : Colors.white,
        side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Container(
        constraints: const BoxConstraints(minWidth: 50),
        decoration: isSelected
            ? BoxDecoration(
                color: const Color(0xFF006B8B),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
