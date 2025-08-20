import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail.dart';
import 'package:homefind/widgets/Colors.dart';

class HistoryBookingPages extends StatefulWidget {
  const HistoryBookingPages({super.key});

  @override
  State<HistoryBookingPages> createState() => _HistoryBookingPagesState();
}

class _HistoryBookingPagesState extends State<HistoryBookingPages> {
  final List<Map<String, String>> allBookings = [
    {
      'id': 'B45678787876',
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ວຽງຈັນ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B46768787876',
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B456670976',
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ຍົກເລີກ',
      'type': 'ເຊົ່າ',
    },
    {
      'id': 'B4567887876',
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'assets/images/house.jpg',
      'price': '75,000',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B4567098876',
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'assets/images/house.jpg',
      'price': '60,000',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ເຊົ່າ',
    },
    {
      'id': 'B567787876',
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ວຽງຈັນ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B09876676',
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ເຊົ່າ',
    },
    {
      'id': 'B455678876576',
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ຍົກເລີກ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B4509876776',
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'assets/images/house.jpg',
      'price': '75,000',
      'status': 'ສຳເລັດ',
      'type': 'ເຊົ່າ',
    },
    {
      'id': 'B4567230966',
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'assets/images/house.jpg',
      'price': '60,000',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B45679787876',
      'title': 'ອະພາດເມັນ',
      'date': '10 ກໍລະກົດ 2025',
      'location': 'ນະຄອນຫຼວງ ວຽງຈັນ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ສຳເລັດ',
      'type': 'ເຊົ່າ',
    },
    {
      'id': 'B49823456876',
      'title': 'ຫ້ອງແຖວແຊຫ້ອງ',
      'date': '25 ມິຖຸນາ 2025',
      'location': 'ໄຊຍະບູລີ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B4556798787876',
      'title': 'ເຮືອນ 2 ຊັ້ນ',
      'date': '15 ພຶດສະພາ 2025',
      'location': 'ເຊກອງ',
      'image': 'assets/images/house.jpg',
      'price': '50,000',
      'status': 'ຍົກເລີກ',
      'type': 'ເຊົ່າ',
    },
    {
      'id': 'B45679873456',
      'title': 'ວີລ້າ ສະຫງວນ',
      'date': '5 ມິຖຸນາ 2025',
      'location': 'ຫຼວງພະບາງ',
      'image': 'assets/images/house.jpg',
      'price': '75,000',
      'status': 'ສຳເລັດ',
      'type': 'ຂາຍ',
    },
    {
      'id': 'B458765677876',
      'title': 'ໂຮງແຮມດີສະຫຼາດ',
      'date': '30 ພຶດສະພາ 2025',
      'location': 'ຈຳປາສັກ',
      'image': 'assets/images/house.jpg',
      'price': '60,000',
      'status': 'ລໍຖ້າຢືນຢັນ',
      'type': 'ເຊົ່າ',
    },
  ];

  String? _selectedStatusFilter;
  String? _selectedTypeFilter;

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

  String _getLocalizedStatus(String status, S l10n) {
    switch (status) {
      case 'ສຳເລັດ':
        return l10n.completed;
      case 'ລໍຖ້າຢືນຢັນ':
        return l10n.pending;
      case 'ຍົກເລີກ':
        return l10n.cancelled;
      default:
        return status;
    }
  }

  // Helper method to get localized type text
  String _getLocalizedType(String type, S l10n) {
    switch (type) {
      case 'ເຊົ່າ':
        return l10n.rent;
      case 'ຂາຍ':
        return l10n.sale;
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: Text(
          l10n.bookingHistory,
          style: const TextStyle(
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
                  _buildStatusFilterButton(l10n.all, null, l10n),
                  const SizedBox(width: 2),
                  _buildStatusFilterButton(l10n.completed, 'ສຳເລັດ', l10n),
                  const SizedBox(width: 2),
                  _buildStatusFilterButton(l10n.pending, 'ລໍຖ້າຢືນຢັນ', l10n),
                  const SizedBox(width: 2),
                  _buildStatusFilterButton(l10n.cancelled, 'ຍົກເລີກ', l10n),
                  const SizedBox(width: 2),
                  Container(
                    height: 32,
                    constraints: const BoxConstraints(minWidth: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.color1,
                      border: Border.all(
                        color: _selectedTypeFilter == null
                            ? Colors.grey
                            : AppColors.color1,
                        width: 0.6,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButton<String>(
                      value: _selectedTypeFilter,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 20,
                      ),
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(12),
                      dropdownColor: Colors.white,
                      selectedItemBuilder: (BuildContext context) {
                        return [l10n.all, l10n.rent, l10n.sale].map<Widget>((
                          String value,
                        ) {
                          return Text(
                            value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                      items:
                          <Map<String, String?>>[
                            {'label': l10n.all, 'value': null},
                            {'label': l10n.rent, 'value': 'ເຊົ່າ'},
                            {'label': l10n.sale, 'value': 'ຂາຍ'},
                          ].map<DropdownMenuItem<String>>((
                            Map<String, String?> item,
                          ) {
                            return DropdownMenuItem<String>(
                              value: item['value'],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  item['label']!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTypeFilter = newValue;
                        });
                      },
                      isDense: true,
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
                  childAspectRatio: 0.80,
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
                                              _getLocalizedStatus(
                                                booking['status']!,
                                                l10n,
                                              ),
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
                                            '₭ ${booking['price'] ?? ''}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF006B8B),
                                            ),
                                          ),
                                          if (booking['type'] != null)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: _getTypeColor(
                                                  booking['type'],
                                                ).withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: _getTypeColor(
                                                    booking['type'],
                                                  ),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                _getLocalizedType(
                                                  booking['type']!,
                                                  l10n,
                                                ),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: _getTypeColor(
                                                    booking['type'],
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                ),
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

  Widget _buildStatusFilterButton(String label, String? status, S l10n) {
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
                color: AppColors.color1,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Icon(Icons.check, color: Colors.white, size: 16),
                const SizedBox(width: 6),
              ],
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
