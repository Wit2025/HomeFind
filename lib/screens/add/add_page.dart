import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _primaryColor = const Color.fromARGB(255, 87, 167, 177);
  // ignore: unused_field
  final _darkPrimaryColor = const Color.fromARGB(255, 12, 105, 122);

  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory = "ເຮືອນ";
  String? _selectedStatus = "ເຊົ່າ";
  String? _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
  List<File> _selectedImages = [];
  bool _isLoading = false;

  // Form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  // ใช้ภาษาลาวเป็น key เหมือนเดิม
  Map<String, bool> _amenities = {
    'ຈອດລົດ': false,
    'ອິນເຕີເນັດ': false,
    'ເຄື່ອງເຮືອນ': false,
    'ສະລອຍນ້ໍາ': false,
    'ຕູ້ເຢັນ': false,
    'ກວດຄົນເຂົ້າ': false,
    'ແອ': false,
    'ເຄື່ອງຊັກຜ້າ': false,
  };

  // Method สำหรับแสดงชื่อสิ่งอำนวยความสะดวกตามภาษา
  String _getAmenityDisplayName(String laoKey) {
    switch (laoKey) {
      case 'ຈອດລົດ':
        return S.of(context).parking;
      case 'ອິນເຕີເນັດ':
        return S.of(context).internet;
      case 'ເຄື່ອງເຮືອນ':
        return S.of(context).home_appliance;
      case 'ສະລອຍນ້ໍາ':
        return S.of(context).swimming;
      case 'ຕູ້ເຢັນ':
        return S.of(context).refrigerator;
      case 'ກວດຄົນເຂົ້າ':
        return S.of(context).security_check;
      case 'ແອ':
        return S.of(context).air;
      case 'ເຄື່ອງຊັກຜ້າ':
        return S.of(context).washing_machine;
      default:
        return laoKey; // แสดงภาษาลาวถ้าไม่มี localization
    }
  }

  // ใช้ภาษาลาวเป็น key
  IconData _getAmenityIcon(String laoKey) {
    switch (laoKey) {
      case 'ຈອດລົດ':
        return Icons.local_parking;
      case 'ອິນເຕີເນັດ':
        return Icons.wifi;
      case 'ເຄື່ອງເຮືອນ':
        return Icons.home;
      case 'ສະລອຍນ້ໍາ':
        return Icons.pool;
      case 'ຕູ້ເຢັນ':
        return Icons.kitchen;
      case 'ກວດຄົນເຂົ້າ':
        return Icons.security;
      case 'ແອ':
        return Icons.ac_unit;
      case 'ເຄື່ອງຊັກຜ້າ':
        return Icons.local_laundry_service;
      default:
        return Icons.check;
    }
  }

  // Helper method to get category display name
  String _getCategoryDisplayName(String value) {
    switch (value) {
      case 'ເຮືອນ':
        return S.of(context).house;
      case 'ຫ້ອງແຖວ':
        return S.of(context).townhouse;
      case 'ອາພາດເມັ້ນ':
        return S.of(context).apartment;
      case 'ດິນ':
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
        return value;
    }
  }

  // Helper method to get status display name
  String _getStatusDisplayName(String value) {
    switch (value) {
      case 'ເຊົ່າ':
        return S.of(context).rent;
      case 'ຂາຍ':
        return S.of(context).sale;
      default:
        return value;
    }
  }

  // Helper method to get room sharing display name
  String _getRoomSharingDisplayName(String value) {
    switch (value) {
      case 'ແຊຫ້ອງ':
        return S.of(context).share_room;
      case 'ບໍ່ແຊຫ້ອງ':
        return S.of(context).no_share_room;
      default:
        return value;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).post_delivery,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
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
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Basic Information
                    _buildSectionHeader(S.of(context).your_accommodation_info),
                    const SizedBox(height: 12),

                    // Property Images
                    _buildImageUploadSection(),
                    const SizedBox(height: 20),

                    // Property Title
                    _buildInputField(
                      label: S.of(context).accommodation_name,
                      controller: _titleController,
                      icon: Icons.title,
                      validator: (value) => value?.isEmpty ?? true
                          ? S.of(context).please_enter_accommodation_name
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Property Category
                    _buildDropdownSection(
                      S.of(context).accommodation_type,
                      _selectedCategory,
                      [
                        'ເຮືອນ',
                        'ຫ້ອງແຖວ',
                        'ອາພາດເມັ້ນ',
                        'ດິນ',
                        'ແຊທີ່ພັກ',
                        'ຕິດຕັ້ງແອ',
                        'ແກ່ເຄື່ອງ',
                        'ຕິດຕັ້ງແວ່ນ',
                        'ເຟີນີເຈີ້',
                      ],
                      (value) => setState(() => _selectedCategory = value),
                      Icons.category,
                      displayNameMapper: _getCategoryDisplayName,
                    ),
                    const SizedBox(height: 16),

                    // Property Status
                    _buildDropdownSection(
                      'ສະຖານະ',
                      _selectedStatus,
                      ['ເຊົ່າ', 'ຂາຍ'],
                      (value) => setState(() => _selectedStatus = value),
                      Icons.sell,
                      displayNameMapper: _getStatusDisplayName,
                    ),
                    const SizedBox(height: 16),

                    // Room Sharing (only shown if status is "ເຊົ່າ")
                    if (_selectedStatus == 'ເຊົ່າ') ...[
                      _buildDropdownSection(
                        'ການແຊ່ຫ້ອງ',
                        _selectedRoomSharing,
                        ['ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
                        (value) => setState(() => _selectedRoomSharing = value),
                        Icons.people,
                        displayNameMapper: _getRoomSharingDisplayName,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Section 2: Property Details
                    _buildSectionHeader(S.of(context).accommodation_details),
                    const SizedBox(height: 12),

                    // Property Price
                    _buildInputField(
                      label: '${S.of(context).price} (₭)',
                      controller: _priceController,
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true)
                          return S.of(context).please_enter_price;
                        if (double.tryParse(value!) == null) {
                          return S.of(context).please_enter_valid_number;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Property Area
                    _buildInputField(
                      label: S.of(context).size,
                      controller: _areaController,
                      icon: Icons.aspect_ratio,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true)
                          return S.of(context).please_enter_size;
                        if (double.tryParse(value!) == null) {
                          return S.of(context).please_enter_valid_number;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Property Location
                    _buildInputField(
                      label: S.of(context).address,
                      controller: _locationController,
                      icon: Icons.location_on,
                      validator: (value) => value?.isEmpty ?? true
                          ? S.of(context).please_enter_address
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Contact Phone
                    _buildInputField(
                      label: S.of(context).phone,
                      controller: _phoneController,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value?.isEmpty ?? true
                          ? S.of(context).please_enter_phone
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Property Description
                    _buildDescriptionField(),
                    const SizedBox(height: 20),

                    // Amenities Section
                    _buildSectionHeader(S.of(context).facilities),
                    const SizedBox(height: 12),
                    _buildAmenitiesGrid(),
                    const SizedBox(height: 30),

                    // Submit Button
                    _buildSubmitButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: _primaryColor,
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int? maxLength,
  }) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 87, 167, 177),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          counterText: '',
        ),
        keyboardType: keyboardType,
        validator: validator,
        maxLength: maxLength,
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(
          labelText: S.of(context).details,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.all(20),
        ),
        maxLines: 5,
        validator: (value) =>
            value?.isEmpty ?? true ? S.of(context).please_enter_details : null,
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).accommodation_photo_min_1,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 87, 167, 177),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: _selectedImages.isEmpty
              ? _buildEmptyImagePlaceholder()
              : _buildImageRow(),
        ),
        const SizedBox(height: 8),
        _buildImageUploadButton(),
      ],
    );
  }

  Widget _buildEmptyImagePlaceholder() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 40,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).add_photo,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageRow() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            _selectedImages.length + (_selectedImages.length < 10 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _selectedImages.length) {
            return GestureDetector(
              onTap: _pickImages,
              child: Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
            );
          }
          return Stack(
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImages[index],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              // Number label - top left
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Remove button - top right
              Positioned(
                top: 4,
                right: 12,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _pickImages,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 87, 167, 177),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: const Icon(Icons.add_a_photo, color: Colors.white),
        label: Text(
          S.of(context).add_photo,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDropdownSection(
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
    IconData icon, {
    String Function(String)? displayNameMapper,
  }) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 87, 167, 177),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.white),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color.fromARGB(255, 87, 167, 177),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 16),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    displayNameMapper != null ? displayNameMapper(item) : item,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmenitiesGrid() {
    return GridView.builder(
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
        final amenityLaoKey = _amenities.keys.elementAt(index);
        return FilterChip(
          backgroundColor: Colors.white,
          label: Text(
            _getAmenityDisplayName(amenityLaoKey),
          ), // แสดงตามภาษาที่เลือก
          selected: _amenities[amenityLaoKey]!,
          onSelected: (selected) {
            setState(() {
              _amenities[amenityLaoKey] = selected;
            });
          },
          selectedColor: const Color(0xFF00CEB0),
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: _amenities[amenityLaoKey]! ? Colors.white : Colors.black,
          ),
          avatar: Icon(
            _getAmenityIcon(amenityLaoKey), // ใช้ key ภาษาลาว
            color: _amenities[amenityLaoKey]!
                ? Colors.white
                : const Color.fromARGB(255, 87, 167, 177),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 87, 167, 177),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                S.of(context).submit,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _pickImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
          if (_selectedImages.length > 10) {
            _selectedImages = _selectedImages.sublist(0, 10);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).max_10_photos)),
            );
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).photo_selection_error}: $e')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).please_add_min_1_photo)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // Process form data
      // _amenities ยังคงมี key เป็นภาษาลาว: 'ຈອດລົດ', 'ອິນເຕີເນັດ', etc.
      print('Selected amenities: $_amenities');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).added_accommodation_success),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Reset form
      _formKey.currentState!.reset();
      setState(() {
        _selectedImages.clear();
        _selectedCategory = "ເຮືອນ";
        _selectedStatus = "ເຊົ່າ";
        _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
        _amenities = _amenities.map((key, value) => MapEntry(key, false));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${S.of(context).error}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
