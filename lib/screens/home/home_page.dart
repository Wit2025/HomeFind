import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:homefind/screens/home/pages/productDetail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryIndex = 0;
  final TextEditingController _controller = TextEditingController();
  final CarouselSliderController _controllerDot = CarouselSliderController();
  bool _showHint = true;
  String _selectedCategory = "ທັງຫມົດ";
  String _selectedStatus = "ເຊົ່າ";

  // Dialog filter states
  String? _selectedPropertyType = "ທັງໝົດ";
  String? _selectedTime = "ທັງໝົດ";
  String? _selectedPrice = "ທັງໝົດ";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showHint = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
      'date': '4 ມື້ກ່ອນ',
      'price': '250000',
      'views': '120',
      'image': 'assets/images/ap1.jpeg',
      'category': 'ຫ້ອງແຖວ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ແຊຫ້ອງ',
      'priceValue': '250000',
      'dateValue': '4',
    },
    {
      'title': 'ເຮືອນ 3 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1 ປີກ່ອນ',
      'price': '2500000',
      'views': '276',
      'image': 'assets/images/ap2.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'priceValue': '2500000000',
      'dateValue': '365',
    },
    {
      'title': 'ອາພາດເມັ້ນ ທະເລສາບ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ສີສັດຕະນາກ, ດົງປາລານ',
      'date': '1 ອາທິດກ່ອນ',
      'price': '180000',
      'views': '120',
      'image': 'assets/images/ap3.jpeg',
      'category': 'ອາພາດເມັ້ນ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'priceValue': '180000',
      'dateValue': '7',
    },
    {
      'title': 'ອາພາດເມັ້ນ ໃຈກາງເມືອງ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1 ມື້ກ່ອນ',
      'price': '18000000',
      'views': '276',
      'image': 'assets/images/ap4.jpeg',
      'category': 'ອາພາດເມັ້ນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ແຊຫ້ອງ',
      'priceValue': '1800000000',
      'dateValue': '1',
    },
    {
      'title': 'ເຮືອນ 4 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ໄຊເສດຖາ, ບ້ານໄຊທານີ',
      'date': '4 ມື້ກ່ອນ',
      'price': '9500000',
      'views': '95',
      'image': 'assets/images/ap1.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'priceValue': '95000',
      'dateValue': '4',
    },
    {
      'title': 'ເຮືອນ 3 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1 ປີກ່ອນ',
      'price': '2500000',
      'views': '276',
      'image': 'assets/images/ap2.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'priceValue': '2500000000',
      'dateValue': '365',
    },
    {
      'title': 'ດີນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ສີສັດຕະນາກ, ດົງປາລານ',
      'date': '1 ອາທິດກ່ອນ',
      'price': '180000',
      'views': '120',
      'image': 'assets/images/ap3.jpeg',
      'category': 'ດີນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'priceValue': '180000',
      'dateValue': '7',
    },
    {
      'title': 'ອາພາດເມັ້ນ ໃຈກາງເມືອງ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ຈັນທະບຸລີ, ທົ່ງສາງນາງ',
      'date': '1 ມື້ກ່ອນ',
      'price': '18000000',
      'views': '276',
      'image': 'assets/images/ap4.jpeg',
      'category': 'ອາພາດເມັ້ນ',
      'status': 'ຂາຍ',
      'roomSharing': 'ແຊຫ້ອງ',
      'priceValue': '1800000000',
      'dateValue': '1',
    },
    {
      'title': 'ເຮືອນ 5 ຊັ້ນ',
      'location': 'ນະຄອນຫຼວງວຽງຈັນ, ໄຊເສດຖາ, ບ້ານໄຊທານີ',
      'date': '4 ມື້ກ່ອນ',
      'price': '9500000',
      'views': '95',
      'image': 'assets/images/ap1.jpeg',
      'category': 'ເຮືອນ',
      'status': 'ເຊົ່າ',
      'roomSharing': 'ບໍ່ແຊຫ້ອງ',
      'priceValue': '95000',
      'dateValue': '4',
    },
  ];

  // Categories data
  final List<Map<String, dynamic>> categories = [
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
          (a, b) =>
              int.parse(a['dateValue']!).compareTo(int.parse(b['dateValue']!)),
        );
      } else if (_selectedTime == 'ດົນສຸດ') {
        // Sort by oldest (largest dateValue)
        filtered.sort(
          (a, b) =>
              int.parse(b['dateValue']!).compareTo(int.parse(a['dateValue']!)),
        );
      }
    }

    if (_selectedPrice != null && _selectedPrice != 'ທັງໝົດ') {
      if (_selectedPrice == 'ຖືກສຸດ') {
        // Sort by cheapest (smallest priceValue)
        filtered.sort(
          (a, b) => int.parse(
            a['priceValue']!,
          ).compareTo(int.parse(b['priceValue']!)),
        );
      } else if (_selectedPrice == 'ແພງສຸດ') {
        // Sort by most expensive (largest priceValue)
        filtered.sort(
          (a, b) => int.parse(
            b['priceValue']!,
          ).compareTo(int.parse(a['priceValue']!)),
        );
      }
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          colors: [
            const Color.fromARGB(255, 87, 167, 177),
            const Color.fromARGB(255, 12, 105, 122),
          ],
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
      'ຄົ້ນຫາບ້ານຫຼັງຕໍ່ໄປຂອງທ່ານກັບພວກເຮົາ',
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
                if (_showHint)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IgnorePointer(
                      ignoring: true,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'ຄົ້ນຫາຊື່, ທີ່ຢູ່...',
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 87, 167, 177),
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
            'ເຮືອນ, ຫ້ອງແຖວ, ອະພາດເມັ້ນ, ດີນ, ວິວລ່າ, ແຊ່ຫ້ອງ...',
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
            speed: Duration(milliseconds: 100),
          ),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
      ),
    );
  }

  // Categories section widget
  Widget _buildCategoriesSection() {
    return Transform.translate(
      offset: const Offset(0.0, -50.0),
      child: Column(
        children: [
          // Container สำหรับปุ่มหมวดหมู่
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
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
                  // controller: _categoryScrollController, // Add this if you want smooth scrolling
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

  // ALSO UPDATE the _buildCategoryButton method's onTap:
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
        label: 'ໝວດໝູ່ $title',
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
                title,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedCategory == "ທັງຫມົດ" ? 'ທັງໝົດ' : _selectedCategory,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        // SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ຄົ້ນພົບ ${filteredPropertyList.length} ລາຍການ'),
            _buildStatusToggle(),
            _buildFilterButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusToggle() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildStatusButton('ເຊົ່າ'), _buildStatusButton('ຂາຍ')],
      ),
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
          color: isSelected ? Colors.teal.shade200 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
          child: Text(status),
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
      chips.add(_buildFilterChip(_selectedPropertyType!, Colors.teal));
    }

    if (_selectedTime != null && _selectedTime != 'ທັງໝົດ') {
      chips.add(_buildFilterChip(_selectedTime!, Colors.blue));
    }

    if (_selectedPrice != null && _selectedPrice != 'ທັງໝົດ') {
      chips.add(_buildFilterChip(_selectedPrice!, Colors.orange));
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
            'ຄັດກອງ',
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

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredPropertyList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = filteredPropertyList[index];
        return Transform.translate(
          offset: Offset(0, -30),
          child: _buildPropertyCard(
            item['title']!,
            item['location']!,
            item['date']!,
            double.parse(item['price']!),
            item['views']!,
            item['image']!,
            item['category']!,
            item['status']!,
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
            'ບໍ່ມີຂໍ້ມູນ',
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
          ),
          _buildPropertyInfo(title, location, date, price, views, status),
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
                              'Image not found',
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
                  category,
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
  ) {
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
                  status,
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
                    date,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '₭ ${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
              width: 208,
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
                            'ແຊທີ່ພັກ',
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
                              'ຣີເຊັດ',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      _buildRadioGroup(
                        'ແຊທີ່ພັກ',
                        ['ທັງໝົດ', 'ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
                        selectedPlace,
                        (val) => setState(() => selectedPlace = val),
                      ),
                      Divider(),
                      Text(
                        'ເວລາ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRadioGroup(
                        'ເວລາ',
                        ['ທັງໝົດ', 'ລ່າສຸດ', 'ດົນສຸດ'],
                        selectedTime,
                        (val) => setState(() => selectedTime = val),
                      ),
                      Divider(),
                      Text(
                        'ລາຄາ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRadioGroup(
                        'ລາຄາ',
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
                            child: Text('ຍົກເລີກ'),
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
                            child: Text('ຕົກລົງ'),
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
                width: 208,
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
                              'ເວລາ',
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
                                'ຣີເຊັດ',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        _buildRadioGroup(
                          'ເວລາ',
                          ['ທັງໝົດ', 'ລ່າສຸດ', 'ດົນສຸດ'],
                          selectedTime,
                          (val) => setState(() => selectedTime = val),
                        ),
                        Divider(),
                        Text(
                          'ລາຄາ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildRadioGroup(
                          'ລາຄາ',
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
                              child: Text('ຍົກເລີກ'),
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
                              child: Text('ຕົກລົງ'),
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
        return RadioListTile<String>(
          title: Text(option),
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
