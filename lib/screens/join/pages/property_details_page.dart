import 'package:flutter/material.dart';
import 'package:homefind/screens/join/pages/persional_info_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PropertyDetailsPage extends StatefulWidget {
  final Map<String, dynamic> personalData;

  const PropertyDetailsPage({super.key, required this.personalData});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final _primaryColor = const Color.fromARGB(255, 87, 167, 177);
  final _darkPrimaryColor = const Color.fromARGB(255, 12, 105, 122);
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // State variables
  int _selectedCategoryIndex = 0;
  String _selectedCategorybutton = "ເຮືອນ";
  String? _selectedStatus = "ເຊົ່າ";
  String? _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
  String? _selectedRentalPeriod = "ເປັນເດືອນ";
  File? _selectedMainImage;
  List<File> _selectedPropertyImages = [];
  bool _isLoading = false;

  // Amenities selection
  final Map<String, bool> _amenities = {
    'ຈອດລົດ': false,
    'ອິນເຕີເນັດ': false,
    'ເຄື່ອງເຮືອນ': false,
    'ເຮືອນຄາບ': false,
    'ຕູ້ເຢັນ': false,
    'ກວດຄົນເຂົ້າ': false,
    'ແອ': false,
    'ເຄື່ອງຊັກຜ້າ': false,
  };

  // Categories data
  final List<Map<String, dynamic>> categories = [
    {'title': 'ເຮືອນ', 'icon': Icons.home},
    {'title': 'ຫ້ອງແຖວ', 'icon': Icons.home_work},
    {'title': 'ອາພາດເມັ້ນ', 'icon': Icons.apartment},
    {'title': 'ດິນ', 'icon': Icons.landscape},
    {'title': 'ແຊທີ່ພັກ', 'icon': Icons.castle},
    {'title': 'ຕິດຕັ້ງແອ', 'icon': Icons.ac_unit},
    {'title': 'ແກ່ເຄື່ອງ', 'icon': Icons.local_shipping},
    {'title': 'ຕິດຕັ້ງແວ່ນ', 'icon': Icons.window},
    {'title': 'ເຟີນີເຈີ້', 'icon': Icons.chair},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickMainImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedMainImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ຜິດພາດໃນການເລືອກຮູບ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeMainImage() {
    setState(() {
      _selectedMainImage = null;
    });
  }

  Future<void> _pickPropertyImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFiles.isNotEmpty) {
        final int remainingSlots = 16 - _selectedPropertyImages.length;

        if (remainingSlots <= 0) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ເຕັມຈຳນວນ 16 ຮູບແລ້ວ'),
                backgroundColor: Colors.orange,
              ),
            );
          }
          return;
        }

        final List<File> newImages = pickedFiles
            .take(remainingSlots)
            .map((file) => File(file.path))
            .toList();

        setState(() {
          _selectedPropertyImages.addAll(newImages);
        });

        if (pickedFiles.length > remainingSlots && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ສາມາດເພີ່ມໄດ້ສູງສຸດ 16 ຮູບ'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ຜິດພາດໃນການເລືອກຮູບ: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removePropertyImage(int index) {
    setState(() {
      _selectedPropertyImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 14),
                    _buildCategorySection(),
                    const SizedBox(height: 14),
                    _buildMainImageSection(),
                    const SizedBox(height: 14),
                    _buildPropertyImagesSection(),
                    const SizedBox(height: 14),
                    _buildBasicInfoSection(),
                    const SizedBox(height: 14),
                    _buildDetailsSection(),
                    const SizedBox(height: 14),
                    _buildContactSection(),
                    const SizedBox(height: 14),
                    _buildDescriptionSection(),
                    const SizedBox(height: 14),
                    _buildAmenitiesSection(),
                    const SizedBox(height: 40),
                    _buildBottomNavigation(),
                  ],
                ),
              ),
            ),
          ),
          // _buildBottomNavigation(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'ຂໍ້ມູນທີ່ພັກ',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_primaryColor, _darkPrimaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Step 1 - Completed
          GestureDetector(
            onLongPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonalInfoPage()),
            ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
          Container(
            height: 2,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _primaryColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          // Step 2 - Active
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.home, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _primaryColor.withOpacity(0.1),
            _primaryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.home_work_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'ຂໍ້ມູນທີ່ພັກ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 105, 122),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'ກະລຸນາກໍ່ນຂໍ້ມູນທີ່ພັກຂອງທ່ານໃຫ້ຄົບຖ້ວນ ເພື່ອການໂປນໂມດ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ປະເພດບໍລິການ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: GridView.builder(
              // controller: _categoryScrollController, // Add this if you want smooth scrolling
              // scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.8,
              ),
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
      ],
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
          _selectedCategorybutton = title; // Update selected category name
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
                borderRadius: BorderRadius.circular(8),
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

  Widget _buildMainImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ອັບໂຫຼດຮູບຫຼັກທີ່ພັກ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: _pickMainImage,
            child: Container(
              width: 280,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedMainImage != null
                      ? _primaryColor
                      : Colors.grey[300]!,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: _selectedMainImage == null
                  ? _buildEmptyMainImagePlaceholder()
                  : _buildMainImageDisplay(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'ອັບໂຫຼດຮູບຖ່າຍທີ່ພັກໃນປັດຈຸບັນ (1 ຮູບ)',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyMainImagePlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image, size: 50, color: _primaryColor),
        const SizedBox(height: 8),
        Text(
          'ແຕະເພື່ອອັບໂຫຼດຮູບ',
          style: TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMainImageDisplay() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.file(_selectedMainImage!, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: _removeMainImage,
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyImagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ຮູບພາບທີ່ພັກ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: _selectedPropertyImages.isEmpty
              ? _buildEmptyPropertyImagePlaceholder()
              : _buildPropertyImageList(),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _pickPropertyImages,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: _primaryColor,
            ),
            label: Text(
              'ເພີ່ມຮູບພາບ',
              style: TextStyle(
                color: _primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyPropertyImagePlaceholder() {
    return GestureDetector(
      onTap: _pickPropertyImages,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.collections_outlined, size: 50, color: _primaryColor),
            const SizedBox(height: 8),
            Text(
              'ອັບໂຫຼດຮູບພາບທີ່ພັກ',
              style: TextStyle(
                color: _primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'ສູງສຸດ 16 ຮູບ',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImageList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            _selectedPropertyImages.length +
            (_selectedPropertyImages.length < 16 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _selectedPropertyImages.length) {
            return GestureDetector(
              onTap: _pickPropertyImages,
              child: Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 30, color: _primaryColor),
                    const SizedBox(height: 4),
                    Text(
                      'ເພີ່ມຮູບ',
                      style: TextStyle(color: _primaryColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedPropertyImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => _removePropertyImage(index),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ຂໍ້ມູນພື້ນຖານ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: 'ຊື່ທີ່ພັກ',
          controller: _titleController,
          icon: Icons.title_outlined,
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ຊື່ທີ່ພັກ' : null,
        ),

        const SizedBox(height: 8),
        _buildDropdownField(
          'ສະຖານະ',
          _selectedStatus,
          ['ເຊົ່າ', 'ຂາຍ'],
          (value) => setState(() {
            _selectedStatus = value;
            if (value != 'ເຊົ່າ') {
              _selectedRentalPeriod = null;
            } else {
              _selectedRentalPeriod = 'ເປັນເດືອນ';
            }
          }),
          Icons.sell_outlined,
        ),
        const SizedBox(height: 8),
        if (_selectedStatus == 'ເຊົ່າ') ...[
          _buildDropdownField(
            'ລະຍະເວລາເຊົ່າ',
            _selectedRentalPeriod,
            ['ເປັນເດືອນ', 'ເປັນປີ', 'ເປັນ 10 ປີ'],
            (value) => setState(() => _selectedRentalPeriod = value),
            Icons.schedule_outlined,
          ),
          const SizedBox(height: 8),
          _buildDropdownField(
            'ການແຊ່ຫ້ອງ',
            _selectedRoomSharing,
            ['ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
            (value) => setState(() => _selectedRoomSharing = value),
            Icons.people_outlined,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailsSection() {
    String getPriceLabel() {
      if (_selectedStatus == 'ເຊົ່າ') {
        if (_selectedRentalPeriod == 'ເປັນປີ') {
          return 'ລາຄາເປັນປີ (₭)';
        } else {
          return 'ລາຄາເປັນເດືອນ (₭)';
        }
      } else {
        return 'ລາຄາ (₭)';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ລາຄາແລະທີ່ຢູ່',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: getPriceLabel(),
          controller: _priceController,
          icon: Icons.monetization_on_outlined,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'ກະລຸນາໃສ່ລາຄາ';
            if (double.tryParse(value!) == null)
              return 'ກະລຸນາໃສ່ຕົວເລກຖືກຕ້ອງ';
            return null;
          },
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: 'ທີ່ຢູ່',
          controller: _locationController,
          icon: Icons.location_on_outlined,
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ທີ່ຢູ່' : null,
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ຂໍ້ມູນຕິດຕໍ່',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        _buildInputField(
          label: 'ເບີໂທລະສັບ',
          controller: _phoneController,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ກະລຸນາໃສ່ເບີໂທ';
            }
            if (!RegExp(r'^20\d{8}$').hasMatch(value)) {
              return 'ເບີໂທຕ້ອງເລີ່ມດ້ວຍ 20 ແລະ ມີ 10 ຫຼັກ';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ລາຍລະອຽດເພີ່ມເຕີມ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'ລາຍລະອຽດເພີ່ມເຕີ່ມ (ຖ້າມີ)',
              hintText:
                  'ອະທິບາຍລາຍລະອຽດທີ່ພັກ, ສິ່ງອຳນວຍຄວາມສະດວກ, ແລະຂໍ້ມູນອື່ນໆ...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _primaryColor, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.all(20),
            ),
            maxLines: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ສິ່ງອຳນວຍຄວາມສະດວກ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3,
          ),
          itemCount: _amenities.length,
          itemBuilder: (context, index) {
            final amenity = _amenities.keys.elementAt(index);
            final isSelected = _amenities[amenity]!;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _amenities[amenity] = !_amenities[amenity]!;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? _primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? _primaryColor : Colors.grey[300]!,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getAmenityIcon(amenity),
                      color: isSelected ? Colors.white : _primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        amenity,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _primaryColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: _primaryColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: _primaryColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.publish, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'ສົ່ງຂໍ້ມູນ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  IconData _getAmenityIcon(String amenity) {
    switch (amenity) {
      case 'ຈອດລົດ':
        return Icons.local_parking_outlined;
      case 'ອິນເຕີເນັດ':
        return Icons.wifi;
      case 'ເຄື່ອງເຮືອນ':
        return Icons.chair_outlined;
      case 'ສະລອຍນໍ້າ':
        return Icons.pool_outlined;
      case 'ຕູ້ເຢັນ':
        return Icons.kitchen_outlined;
      case 'ກວດຄົນເຂົ້າ':
        return Icons.security_outlined;
      case 'ແອ':
        return Icons.ac_unit_outlined;
      case 'ເຄື່ອງຊັກຜ້າ':
        return Icons.local_laundry_service_outlined;
      default:
        return Icons.check_outlined;
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາກໍ່ນຂໍ້ມູນໃຫ້ຄົບຖ້ວນ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedMainImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາອັບໂຫຼດຮູບຫຼັກທີ່ພັກ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedPropertyImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາເພີ່ມຮູບພາບທີ່ພັກຢ່າງໜ້ອຍ 1 ຮູບ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedStatus == 'ເຊົ່າ' && _selectedRentalPeriod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາເລືອກລະຍະເວລາເຊົ່າ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // Combine personal data and property data
      final completeData = {
        ...widget.personalData,
        'title': _titleController.text,
        'category': _selectedCategorybutton,
        'status': _selectedStatus,
        'rentalPeriod': _selectedRentalPeriod,
        'roomSharing': _selectedRoomSharing,
        'price': _priceController.text,
        'location': _locationController.text,
        'phone': _phoneController.text,
        'description': _descriptionController.text,
        'amenities': _amenities,
        'mainImage': _selectedMainImage,
        'propertyImages': _selectedPropertyImages,
      };

      print('Complete form data: $completeData');

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ຜິດພາດ: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 87, 167, 177),
                const Color.fromARGB(255, 12, 105, 122),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 40, color: Colors.green),
              ),
              const SizedBox(height: 20),
              const Text(
                'ສົ່ງຂໍ້ມູນສຳເລັດ!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'ຂໍ້ມູນຂອງທ່ານໄດ້ຖືກສົ່ງໄປຫາທີມງານແລ້ວ\nລໍຖ້າການກວດສອບແລະອະນຸມັດ\nພວກເຮົາຈະແຈ້ງໃຫ້ທ່ານຊາບໃນໄວໆນີ້',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 170,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text(
                    'ເຂົ້າໃຈແລ້ວ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
