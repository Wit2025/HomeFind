// screens/home/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:homefind/screens/home/home_page/widget/categories_section.dart';
import 'package:homefind/screens/home/home_page/widget/header_section.dart';
import 'package:homefind/screens/home/home_page/widget/property_data.dart';
import 'package:homefind/screens/home/home_page/widget/property_listings_section.dart';
import 'package:homefind/screens/home/home_page/widget/property_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State variables
  int _selectedCategoryIndex = 0;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showHint = true;
  bool _isFocused = false;
  String _selectedCategory = "ທັງຫມົດ";
  String _selectedStatus = "ເຊົ່າ";

  // Dialog filter states
  String? _selectedPropertyType = "ທັງໝົດ";
  String? _selectedTime = "ທັງໝົດ";
  String? _selectedPrice = "ທັງໝົດ";

  // Properties list
  List<Property> _properties = [];

  @override
  void initState() {
    super.initState();
    _initializeProperties();
    _setupControllers();
  }

  void _initializeProperties() {
    _properties = PropertyData.getProperties();
  }

  void _setupControllers() {
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

  // Filter and search methods
  List<Property> get _filteredProperties {
    return PropertyData.filterProperties(
      _properties,
      selectedCategory: _selectedCategory,
      selectedStatus: _selectedStatus,
      selectedPropertyType: _selectedPropertyType,
      selectedTime: _selectedTime,
      selectedPrice: _selectedPrice,
    );
  }

  List<Property> get _displayProperties {
    return _controller.text.isEmpty
        ? _filteredProperties
        : PropertyData.searchProperties(_controller.text, _filteredProperties);
  }

  // Event handlers
  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _selectedCategory = PropertyData.categories[index].title;
    });
  }

  void _onStatusChanged(String status) {
    setState(() {
      _selectedStatus = status;
      // Reset filters when switching status
      _selectedPropertyType = 'ທັງໝົດ';
      _selectedTime = 'ທັງໝົດ';
      _selectedPrice = 'ທັງໝົດ';
    });
  }

  void _onRentFiltersChanged(
    String? propertyType,
    String? time,
    String? price,
  ) {
    setState(() {
      _selectedPropertyType = propertyType;
      _selectedTime = time;
      _selectedPrice = price;
    });
  }

  void _onSaleFiltersChanged(String? time, String? price) {
    setState(() {
      _selectedTime = time;
      _selectedPrice = price;
      _selectedPropertyType = 'ທັງໝົດ'; // Reset property type for sale
    });
  }

  void _onSearchClearPressed() {
    if (_controller.text.isNotEmpty) {
      _controller.clear();
      setState(() {
        _showHint = true;
      });
    } else {
      _focusNode.unfocus();
    }
  }

  void _onSearchPressed() {
    // Add search logic here if needed
  }
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1)); // mock delay โหลดข้อมูล
    setState(() {
      _initializeProperties(); // โหลด properties ใหม่
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _handleRefresh, // ฟังก์ชันรีเฟรช
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // ให้เลื่อนแม้ไม่มีข้อมูล
          child: Column(
            children: [
              HeaderSection(
                controller: _controller,
                focusNode: _focusNode,
                showHint: _showHint,
                isFocused: _isFocused,
                onClearPressed: _onSearchClearPressed,
                onSearchPressed: _onSearchPressed,
              ),
              CategoriesSection(
                selectedCategoryIndex: _selectedCategoryIndex,
                onCategorySelected: _onCategorySelected,
              ),
              Transform.translate(
                offset: const Offset(0, -30),
                child: PropertyListingsSection(
                  selectedCategory: _selectedCategory,
                  selectedStatus: _selectedStatus,
                  selectedPropertyType: _selectedPropertyType,
                  selectedTime: _selectedTime,
                  selectedPrice: _selectedPrice,
                  displayProperties: _displayProperties,
                  onStatusChanged: _onStatusChanged,
                  onRentFiltersChanged: _onRentFiltersChanged,
                  onSaleFiltersChanged: _onSaleFiltersChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
