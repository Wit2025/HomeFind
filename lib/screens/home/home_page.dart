import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/productDetail.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  final TextEditingController _controller = TextEditingController();
  final CarouselSliderController _controllerDot = CarouselSliderController();
  final FocusNode _focusNode = FocusNode();
  bool _showHint = true;
  bool _isFocused = false;
  String _selectedCategory = "ທັງຫມົດ";
  String _selectedStatus = "ເຊົ່າ";

  // Dialog filter states
  String? _selectedPropertyType = "ທັງໝົດ";
  String? _selectedTime = "ທັງໝົດ";
  String? _selectedPrice = "ທັງໝົດ";
  List<Map<String, String>> _searchProperties(String query) {
    if (query.isEmpty) {
      return filteredPropertyList;
    }

    final lowerCaseQuery = query.toLowerCase();

    return filteredPropertyList.where((property) {
      return property['title']!.toLowerCase().contains(lowerCaseQuery) ||
          property['location']!.toLowerCase().contains(lowerCaseQuery) ||
          property['category']!.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showHint = _controller.text.isEmpty;
      });
    });
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void goToCategory(int index) {
    _controllerDot.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<Map<String, String>> propertyList = [
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

  // Categories data with translation helper
  List<Map<String, dynamic>> get categories => [
    {'title': 'ທັງຫມົດ', 'icon': Icons.apps},
    {'title': 'ເຮືອນ', 'icon': Icons.home},
    {'title': 'ຫ້ອງແຖວ', 'icon': Icons.home_work},
    {'title': 'ອາພາດເມັ້ນ', 'icon': Icons.apartment},
    {'title': 'ດີນ', 'icon': Icons.landscape},
    {'title': 'ແຊທີ່ພັກ', 'icon': Icons.castle},
    {'title': 'ຕິດຕັ້ງແອ', 'icon': Icons.ac_unit},
    {'title': 'ແກ່ເຄື່ອງ', 'icon': Icons.local_shipping},
    {'title': 'ຕິດຕັ້ງແວ່ນ', 'icon': Icons.window},
    {'title': 'ເຟີນີເຈີ້', 'icon': Icons.chair},
  ];

  // Translation helper methods
  String _translateCategory(String category) {
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

  String _translateStatus(String status) {
    switch (status) {
      case 'ເຊົ່າ':
        return S.of(context).rent;
      case 'ຂາຍ':
        return S.of(context).sale;
      default:
        return status;
    }
  }

  String _translateRental(String rental) {
    switch (rental) {
      case 'ຕໍ່ປີ':
        return S.of(context).per_m;
      case 'ຕໍ່ເດືອນ':
        return S.of(context).per_y;
      default:
        return rental;
    }
  }

  String _translateRoomSharing(String roomSharing) {
    switch (roomSharing) {
      case 'ທັງໝົດ':
        return S.of(context).all;
      case 'ແຊຫ້ອງ':
        return S.of(context).share_room;
      case 'ບໍ່ແຊຫ້ອງ':
        return S.of(context).no_share_room;
      default:
        return roomSharing;
    }
  }

  String _translateTime(String time) {
    switch (time) {
      case 'ທັງໝົດ':
        return S.of(context).all;
      case 'ລ່າສຸດ':
        return S.of(context).latest;
      case 'ດົນສຸດ':
        return S.of(context).oldest;
      default:
        return time;
    }
  }

  String _translatePrice(String price) {
    switch (price) {
      case 'ທັງໝົດ':
        return S.of(context).all;
      case 'ຖືກສຸດ':
        return S.of(context).cheapest;
      case 'ແພງສຸດ':
        return S.of(context).most_expensive;
      default:
        return price;
    }
  }

  // Enhanced filtering logic
  List<Map<String, String>> get filteredPropertyList {
    List<Map<String, String>> filtered = propertyList.where((property) {
      // Category filter
      bool categoryMatch =
          _selectedCategory == "ທັງຫມົດ" ||
          property['category'] == _selectedCategory;

      // Status filter (rent/sale)
      bool statusMatch = property['status'] == _selectedStatus;

      // Room sharing filter (only for rent)
      bool roomSharingMatch = true;
      if (_selectedStatus == 'ເຊົ່າ' &&
          _selectedPropertyType != null &&
          _selectedPropertyType != 'ທັງໝົດ') {
        roomSharingMatch = property['roomSharing'] == _selectedPropertyType;
      }

      return categoryMatch && statusMatch && roomSharingMatch;
    }).toList();

    // Apply sorting based on selected filters
    if (_selectedTime != null && _selectedTime != 'ທັງໝົດ') {
      if (_selectedTime == 'ລ່າສຸດ') {
        // Sort by most recent (smallest dateValue)
        filtered.sort(
          (a, b) => int.parse(a['date']!).compareTo(int.parse(b['date']!)),
        );
      } else if (_selectedTime == 'ດົນສຸດ') {
        // Sort by oldest (largest date)
        filtered.sort(
          (a, b) => int.parse(b['date']!).compareTo(int.parse(a['date']!)),
        );
      }
    }

    if (_selectedPrice != null && _selectedPrice != 'ທັງໝົດ') {
      if (_selectedPrice == 'ຖືກສຸດ') {
        // Sort by cheapest (smallest priceValue)
        filtered.sort(
          (a, b) => int.parse(a['price']!).compareTo(int.parse(b['price']!)),
        );
      } else if (_selectedPrice == 'ແພງສຸດ') {
        // Sort by most expensive (largest priceValue)
        filtered.sort(
          (a, b) => int.parse(b['price']!).compareTo(int.parse(a['price']!)),
        );
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildCategoriesSection(),
            Transform.translate(
              offset: const Offset(0, -30),
              child: _buildPropertyListingsSection(),
            ),
          ],
        ),
      ),
    );
  }

  // Header section widget
  Widget _buildHeaderSection() {
    return Container(
      height: 340,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.color1, AppColors.color2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(26),
        child: Column(
          children: [
            SizedBox(height: 65),
            _buildHeaderTitle(),
            SizedBox(height: 25),
            _buildSearchBar(),
            SizedBox(height: 25),
            _buildAnimatedSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Text(
      S.of(context).find_next_home,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                if (_showHint && !_isFocused) // แก้ไขเงื่อนไขนี้
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IgnorePointer(
                      ignoring: true,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            S.of(context).search_name_address,
                            textStyle: TextStyle(color: Colors.grey),
                            speed: Duration(milliseconds: 100),
                            cursor: '',
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                    ),
                  ),
                TextField(
                  controller: _controller,
                  focusNode: _focusNode, // เพิ่มบรรทัดนี้
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                    // เพิ่ม padding ขวาเมื่อมี focus หรือมีข้อความ
                    contentPadding: EdgeInsets.only(
                      left: 12,
                      right: (_isFocused || _controller.text.isNotEmpty)
                          ? 40
                          : 12, // แก้ไขเงื่อนไขนี้
                      top: 12,
                      bottom: 12,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                // แสดงปุ่มล้างเมื่อมี focus หรือมีข้อความ
                if (_isFocused ||
                    _controller.text.isNotEmpty) // แก้ไขเงื่อนไขนี้
                  Positioned(
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        if (_controller.text.isNotEmpty) {
                          _controller.clear();
                          setState(() {
                            _showHint = true;
                          });
                        } else {
                          // ถ้าไม่มีข้อความ ให้ unfocus
                          _focusNode.unfocus();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          _controller.text.isNotEmpty
                              ? Icons.clear
                              : Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // สามารถเพิ่ม logic การค้นหาที่นี่
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.color1,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSubtitle() {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            S.of(context).property_types,
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
            speed: Duration(milliseconds: 100),
          ),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Transform.translate(
      offset: const Offset(0.0, -50.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: SizedBox(
                height: 80, // ความสูงคงที่
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _buildCategoryButton(
                        category['title'],
                        category['icon'],
                        _selectedCategoryIndex == index,
                        index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Dot indicator ที่ปรับปรุงแล้ว
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _selectedCategoryIndex,
                count: categories.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey.shade300,
                  expansionFactor: 4,
                  spacing: 8,
                ),
                onDotClicked: (index) {
                  // Safe dot click handling - no carousel navigation needed
                  setState(() {
                    _selectedCategoryIndex = index;
                    _selectedCategory = categories[index]['title'];
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    String title,
    IconData icon,
    bool isSelected,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        // Simple state update without carousel navigation
        setState(() {
          _selectedCategoryIndex = index;
          _selectedCategory = title; // Update selected category name
        });
      },
      child: Semantics(
        button: true,
        selected: isSelected,
        label: '${S.of(context).category} ${_translateCategory(title)}',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container สำหรับ icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal.shade100 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: Colors.teal.shade200, width: 1)
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.teal : Colors.grey,
                size: 27,
              ),
            ),

            const SizedBox(height: 6),

            // Text ที่ปรับปรุงแล้ว
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(
                _translateCategory(title),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Property listings section widget
  Widget _buildPropertyListingsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [_buildListingsHeader(), _buildPropertyGrid()]),
    );
  }

  Widget _buildListingsHeader() {
    final displayList = _controller.text.isEmpty
        ? filteredPropertyList
        : _searchProperties(_controller.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _translateCategory(_selectedCategory),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            _buildStatusToggle(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${S.of(context).found} ${displayList.length} ${S.of(context).listing}',
            ),
            _buildFilterButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildStatusButton('ເຊົ່າ'), _buildStatusButton('ຂາຍ')],
    );
  }

  Widget _buildStatusButton(String status) {
    bool isSelected = _selectedStatus == status;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status;
          // Reset filters when switching status
          _selectedPropertyType = 'ທັງໝົດ';
          _selectedTime = 'ທັງໝົດ';
          _selectedPrice = 'ທັງໝົດ';
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 32,
        width: 70,
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
          child: Text(_translateStatus(status)),
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (_selectedStatus == 'ເຊົ່າ') {
            _showRentDialog(context);
          } else if (_selectedStatus == 'ຂາຍ') {
            _showSaleDialog(context);
          }
        },
        child: Container(
          height: 32,
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [..._buildActiveFilterChips(), _buildFilterIcon()],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActiveFilterChips() {
    List<Widget> chips = [];

    if (_selectedPropertyType != null && _selectedPropertyType != 'ທັງໝົດ') {
      chips.add(
        _buildFilterChip(
          _translateRoomSharing(_selectedPropertyType!),
          Colors.teal,
        ),
      );
    }

    if (_selectedTime != null && _selectedTime != 'ທັງໝົດ') {
      chips.add(_buildFilterChip(_translateTime(_selectedTime!), Colors.blue));
    }

    if (_selectedPrice != null && _selectedPrice != 'ທັງໝົດ') {
      chips.add(
        _buildFilterChip(_translatePrice(_selectedPrice!), Colors.orange),
      );
    }

    return chips;
  }

  Widget _buildFilterChip(String text, MaterialColor color) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFilterIcon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).filter,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 2),
          Icon(Icons.keyboard_arrow_down, size: 16),
        ],
      ),
    );
  }

  Widget _buildPropertyGrid() {
    // Check if the filtered list is empty
    if (filteredPropertyList.isEmpty) {
      return _buildEmptyState();
    }
    final displayList = _controller.text.isEmpty
        ? filteredPropertyList
        : _searchProperties(_controller.text);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = displayList[index];
        return Transform.translate(
          offset: const Offset(0, -20),
          child: _buildPropertyCard(
            item['title']!,
            item['location']!,
            item['date']!,
            double.parse(item['price']!),
            item['views']!,
            item['image']!,
            item['category']!,
            item['status']!,
            item['rental'],
            item['currency'] ?? 'LAK',
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          // World icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/icons/city.png', fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),

          // No data text
          Text(
            S.of(context).no_data,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(
    String title,
    String location,
    String date,
    double price,
    String views,
    String image,
    String category,
    String status,
    String? rental,
    String? currency,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPropertyImage(
            image,
            category,
            title,
            location,
            date,
            price,
            views,
            status,
            rental,
            currency,
          ),
          _buildPropertyInfo(
            title,
            location,
            date,
            price,
            views,
            status,
            rental,
            currency,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyImage(
    String image,
    String category,
    String title,
    String location,
    String date,
    double price,
    String views,
    String status,
    String? rental,
    String? currency,
  ) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(
                          title: title,
                          location: location,
                          date: date,
                          price: price,
                          views: views,
                          image: image,
                          category: category,
                          status: status,
                          currency: currency,
                          rental: rental,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              size: 40,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(height: 8),
                            Text(
                              S.of(context).no_image,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _translateCategory(category),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyInfo(
    String title,
    String location,
    String date,
    double price,
    String views,
    String status,
    String? rental,
    String? currency,
  ) {
    final formattedPrice = NumberFormat("#,##0.00", "en_US").format(price);
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  _translateStatus(status),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: status == 'ຂາຍ' ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 15, color: Colors.blueGrey),
                Expanded(
                  child: Text(
                    location,
                    style: TextStyle(color: Colors.black, fontSize: 10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.timer, size: 12, color: Colors.blueGrey),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${S.of(context).daysAgo(date)}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                SizedBox(width: 5),
                Row(
                  children: [
                    Icon(Icons.visibility, size: 12, color: Colors.grey),
                    SizedBox(width: 2),
                    Text(
                      views,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$formattedPrice ${currency ?? "LAK"}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (status == 'ເຊົ່າ' &&
                                  rental != null &&
                                  rental.isNotEmpty) ...[
                                WidgetSpan(child: SizedBox(width: 5)),
                                TextSpan(
                                  text: _translateRental(rental),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Dialog methods
  void _showRentDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Filter Dialog',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        String selectedPlace = _selectedPropertyType ?? 'ທັງໝົດ';
        String selectedTime = _selectedTime ?? 'ທັງໝົດ';
        String selectedPrice = _selectedPrice ?? 'ທັງໝົດ';

        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            child: Container(
              width: 235,
              margin: const EdgeInsets.only(right: 16, bottom: 16),
              padding: const EdgeInsets.all(16),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).accommodation_zone,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedPlace = 'ທັງໝົດ';
                                selectedTime = 'ທັງໝົດ';
                                selectedPrice = 'ທັງໝົດ';
                              });
                              this.setState(() {
                                _selectedPropertyType = 'ທັງໝົດ';
                                _selectedTime = 'ທັງໝົດ';
                                _selectedPrice = 'ທັງໝົດ';
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              S.of(context).reset,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      _buildRadioGroup(
                        S.of(context).accommodation_zone,
                        ['ທັງໝົດ', 'ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
                        selectedPlace,
                        (val) => setState(() => selectedPlace = val),
                      ),
                      Divider(),
                      Text(
                        S.of(context).time,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRadioGroup(
                        S.of(context).time,
                        ['ທັງໝົດ', 'ລ່າສຸດ', 'ດົນສຸດ'],
                        selectedTime,
                        (val) => setState(() => selectedTime = val),
                      ),
                      Divider(),
                      Text(
                        S.of(context).price,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRadioGroup(
                        S.of(context).price,
                        ['ທັງໝົດ', 'ຖືກສຸດ', 'ແພງສຸດ'],
                        selectedPrice,
                        (val) => setState(() => selectedPrice = val),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(S.of(context).cancel),
                          ),
                          const SizedBox(width: 6),
                          ElevatedButton(
                            onPressed: () {
                              this.setState(() {
                                _selectedPropertyType = selectedPlace;
                                _selectedTime = selectedTime;
                                _selectedPrice = selectedPrice;
                              });
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade200,
                            ),
                            child: Text(S.of(context).understood),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSaleDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Filter Dialog',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );

        String selectedTime = _selectedTime ?? 'ທັງໝົດ';
        String selectedPrice = _selectedPrice ?? 'ທັງໝົດ';

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              child: Container(
                width: 235,
                margin: const EdgeInsets.only(right: 16, bottom: 16),
                padding: const EdgeInsets.all(16),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).time,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedTime = 'ທັງໝົດ';
                                  selectedPrice = 'ທັງໝົດ';
                                });
                                this.setState(() {
                                  _selectedTime = 'ທັງໝົດ';
                                  _selectedPrice = 'ທັງໝົດ';
                                  _selectedPropertyType = 'ທັງໝົດ';
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                S.of(context).reset,
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        _buildRadioGroup(
                          S.of(context).time,
                          ['ທັງໝົດ', 'ລ່າສຸດ', 'ດົນສຸດ'],
                          selectedTime,
                          (val) => setState(() => selectedTime = val),
                        ),
                        Divider(),
                        Text(
                          S.of(context).price,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildRadioGroup(
                          S.of(context).price,
                          ['ທັງໝົດ', 'ຖືກສຸດ', 'ແພງສຸດ'],
                          selectedPrice,
                          (val) => setState(() => selectedPrice = val),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(S.of(context).cancel),
                            ),
                            const SizedBox(width: 6),
                            ElevatedButton(
                              onPressed: () {
                                this.setState(() {
                                  _selectedTime = selectedTime;
                                  _selectedPrice = selectedPrice;
                                  _selectedPropertyType = 'ທັງໝົດ';
                                });
                                Navigator.of(context).pop();
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade200,
                              ),
                              child: Text(S.of(context).understood),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRadioGroup(
    String groupName,
    List<String> options,
    String selectedValue,
    void Function(String) onChanged,
  ) {
    return Column(
      children: options.map((option) {
        String displayText = option;
        // Translate the display text based on the group
        if (groupName == S.of(context).accommodation_zone) {
          displayText = _translateRoomSharing(option);
        } else if (groupName == S.of(context).time) {
          displayText = _translateTime(option);
        } else if (groupName == S.of(context).price) {
          displayText = _translatePrice(option);
        }

        return RadioListTile<String>(
          title: Text(displayText),
          value: option,
          groupValue: selectedValue,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          dense: true,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        );
      }).toList(),
    );
  }
}
