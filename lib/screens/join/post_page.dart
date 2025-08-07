import 'package:flutter/material.dart';
import 'package:homefind/screens/main_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _primaryColor = const Color.fromARGB(255, 87, 167, 177);
  final _darkPrimaryColor = const Color.fromARGB(255, 12, 105, 122);

  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory = "ເຮືອນ";
  String? _selectedStatus = "ເຊົ່າ";
  String? _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
  String? _selectedDocumentType = "ບັດປະຈຳຕົວ"; // ID Card, Passport, etc.

  // Image lists
  List<File> _selectedPropertyImages = [];
  List<File> _selectedDocumentImages = [];
  bool _isLoading = false;

  // Form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _areaController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _documentNumberController =
      TextEditingController();

  // Amenities selection
  Map<String, bool> _amenities = {
    'ຈອດລົດ': false,
    'ອິນເຕີເນັດ': false,
    'ເຄື່ອງເຮືອນ': false,
    'ເຮືອນຄາບ': false,
    'ຕູ້ເຢັນ': false,
    'ກວດຄົນເຂົ້າ': false,
    'ແອ': false,
    'ເຄື່ອງຊັກຜ້າ': false,
  };

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    // _areaController.dispose();
    _ownerNameController.dispose();
    _documentNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ປ້ອນຂໍ້ມູນ',
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
                    // Section 1: Owner Verification
                    _buildSectionHeader('ຂໍ້ມູນເຈົ້າຂອງທີ່ພັກ'),
                    const SizedBox(height: 12),

                    _buildInputField(
                      label: 'ຊື່ເຈົ້າຂອງທີ່ພັກ',
                      controller: _ownerNameController,
                      icon: Icons.person,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'ກະລຸນາໃສ່ຊື່ເຈົ້າຂອງທີ່ພັກ'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    _buildDropdownSection(
                      'ປະເພດເອກະສານ',
                      _selectedDocumentType,
                      ['ບັດປະຈຳຕົວ', 'ໜັງສືຜ່ານແດນ', 'ສຳມະໂນຄົວ'],
                      (value) => setState(() => _selectedDocumentType = value),
                      Icons.credit_card,
                    ),
                    const SizedBox(height: 16),

                    _buildInputField(
                      label: 'ເລກທີເອກະສານ',
                      controller: _documentNumberController,
                      icon: Icons.numbers,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'ກະລຸນາໃສ່ເລກທີເອກະສານ'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Document Upload Section
                    _buildDocumentUploadSection(),
                    const SizedBox(height: 20),

                    // Section 2: Property Information
                    _buildSectionHeader('ຂໍ້ມູນທີ່ພັກຂອງທ່ານ'),
                    const SizedBox(height: 12),

                    _buildPropertyImageUploadSection(),
                    const SizedBox(height: 20),

                    _buildInputField(
                      label: 'ຊື່ທີ່ພັກ',
                      controller: _titleController,
                      icon: Icons.title,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ຊື່ທີ່ພັກ' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildDropdownSection(
                      'ປະເພດທີ່ພັກ',
                      _selectedCategory,
                      ['ເຮືອນ', 'ຫ້ອງແຖວ', 'ວິວລ່າ', 'ອາພາດເມັ້ນ', 'ຄອນໂດ'],
                      (value) => setState(() => _selectedCategory = value),
                      Icons.category,
                    ),
                    const SizedBox(height: 16),

                    _buildDropdownSection(
                      'ສະຖານະ',
                      _selectedStatus,
                      ['ເຊົ່າ', 'ຂາຍ'],
                      (value) => setState(() => _selectedStatus = value),
                      Icons.sell,
                    ),
                    const SizedBox(height: 16),

                    if (_selectedStatus == 'ເຊົ່າ') ...[
                      _buildDropdownSection(
                        'ການແຊ່ຫ້ອງ',
                        _selectedRoomSharing,
                        ['ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
                        (value) => setState(() => _selectedRoomSharing = value),
                        Icons.people,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Section 3: Property Details
                    _buildSectionHeader('ລາຍລະອຽດທີ່ພັກ'),
                    const SizedBox(height: 12),

                    _buildInputField(
                      label: 'ລາຄາ (₭)',
                      controller: _priceController,
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'ກະລຸນາໃສ່ລາຄາ';
                        if (double.tryParse(value!) == null)
                          return 'ກະລຸນາໃສ່ຕົວເລກຖືກຕ້ອງ';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // _buildInputField(
                    //   label: 'ຂະໜາດ (ຕລ.ມ.)',
                    //   controller: _areaController,
                    //   icon: Icons.aspect_ratio,
                    //   keyboardType: TextInputType.number,
                    //   validator: (value) {
                    //     if (value?.isEmpty ?? true) return 'ກະລຸນາໃສ່ຂະໜາດ';
                    //     if (double.tryParse(value!) == null) return 'ກະລຸນາໃສ່ຕົວເລກຖືກຕ້ອງ';
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 16),

                    _buildInputField(
                      label: 'ທີ່ຢູ່',
                      controller: _locationController,
                      icon: Icons.location_on,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ທີ່ຢູ່' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildInputField(
                      label: 'ເບີໂທລະສັບ',
                      controller: _phoneController,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ເບີໂທ' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildDescriptionField(),
                    const SizedBox(height: 20),

                    // Section 4: Amenities
                    _buildSectionHeader('ສິ່ງອຳນວຍຄວາມສະດວກ'),
                    const SizedBox(height: 12),
                    _buildAmenitiesGrid(),
                    const SizedBox(height: 30),

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: _primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(width: 4, color: _primaryColor)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _primaryColor,
        ),
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
          prefixIcon: Icon(icon, color: _primaryColor),
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
          labelText: 'ລາຍລະອຽດ',
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
            value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ລາຍລະອຽດ' : null,
      ),
    );
  }

  Widget _buildDocumentUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.verified_user, color: _primaryColor, size: 20),
            const SizedBox(width: 8),
            const Text(
              'ອັບໂຫລດເອກະສານຢັ້ງຢືນ (ຈຳເປັນ)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 87, 167, 177),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.orange[700], size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'ກະລຸນາອັບໂຫລດຮູບພາບເອກະສານທີ່ຊັດເຈນ ເພື່ອການຢັ້ງຢືນຕົວຕົນ',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: _selectedDocumentImages.isEmpty
              ? _buildEmptyDocumentPlaceholder()
              : _buildDocumentImageRow(),
        ),
        const SizedBox(height: 8),
        _buildDocumentUploadButton(),
      ],
    );
  }

  Widget _buildEmptyDocumentPlaceholder() {
    return GestureDetector(
      onTap: _pickDocumentImages,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          border: Border.all(
            color: Colors.red.withOpacity(0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.credit_card, size: 40, color: Colors.red[600]),
            const SizedBox(height: 8),
            Text(
              'ອັບໂຫລດເອກະສານ',
              style: TextStyle(
                color: Colors.red[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '(ບັດປະຈຳຕົວ/ໜັງສືຜ່ານແດນ)',
              style: TextStyle(color: Colors.red[400], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentImageRow() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            _selectedDocumentImages.length +
            (_selectedDocumentImages.length < 3 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _selectedDocumentImages.length) {
            return GestureDetector(
              onTap: _pickDocumentImages,
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
                    _selectedDocumentImages[index],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 12,
                child: GestureDetector(
                  onTap: () => _removeDocumentImage(index),
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

  Widget _buildDocumentUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _pickDocumentImages,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[600],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: const Icon(Icons.upload_file, color: Colors.white),
        label: const Text(
          'ອັບໂຫລດເອກະສານ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPropertyImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ຮູບພາບທີ່ພັກ (ຢ່າງໜ້ອຍ 1 ຮູບ)',
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
          child: _selectedPropertyImages.isEmpty
              ? _buildEmptyPropertyImagePlaceholder()
              : _buildPropertyImageRow(),
        ),
        const SizedBox(height: 8),
        _buildPropertyImageUploadButton(),
      ],
    );
  }

  Widget _buildEmptyPropertyImagePlaceholder() {
    return GestureDetector(
      onTap: _pickPropertyImages,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 40, color: Colors.grey[600]),
            const SizedBox(height: 8),
            Text(
              'ເພີ່ມຮູບພາບທີ່ພັກ',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImageRow() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            _selectedPropertyImages.length +
            (_selectedPropertyImages.length < 10 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _selectedPropertyImages.length) {
            return GestureDetector(
              onTap: _pickPropertyImages,
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
                    _selectedPropertyImages[index],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 12,
                child: GestureDetector(
                  onTap: () => _removePropertyImage(index),
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

  Widget _buildPropertyImageUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _pickPropertyImages,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: const Icon(Icons.add_a_photo, color: Colors.white),
        label: const Text(
          'ເພີ່ມຮູບພາບທີ່ພັກ',
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
    IconData icon,
  ) {
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
          prefixIcon: Icon(icon, color: _primaryColor),
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
              icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
              style: const TextStyle(color: Colors.black, fontSize: 16),
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
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
        childAspectRatio: 3.5,
      ),
      itemCount: _amenities.length,
      itemBuilder: (context, index) {
        final amenity = _amenities.keys.elementAt(index);
        return FilterChip(
          backgroundColor: Colors.white,
          label: Text(amenity),
          selected: _amenities[amenity]!,
          onSelected: (selected) {
            setState(() {
              _amenities[amenity] = selected;
            });
          },
          selectedColor: const Color(0xFF00CEB0),
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: _amenities[amenity]! ? Colors.white : Colors.black,
            fontSize: 13,
          ),
          avatar: Icon(
            _getAmenityIcon(amenity),
            color: _amenities[amenity]! ? Colors.white : _primaryColor,
            size: 18,
          ),
        );
      },
    );
  }

  IconData _getAmenityIcon(String amenity) {
    switch (amenity) {
      case 'ຈອດລົດ':
        return Icons.local_parking;
      case 'ອິນເຕີເນັດ':
        return Icons.wifi;
      case 'ເຄື່ອງເຮືອນ':
        return Icons.chair;
      case 'ເຮືອນຄາບ':
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'ສົ່ງຂໍ້ມູນ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _pickPropertyImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedPropertyImages.addAll(
            pickedFiles.map((file) => File(file.path)),
          );
          if (_selectedPropertyImages.length > 10) {
            _selectedPropertyImages = _selectedPropertyImages.sublist(0, 10);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ສາມາດເພີ່ມຮູບທີ່ພັກໄດ້ສູງສຸດ 10 ຮູບ'),
              ),
            );
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ຜິດພາດໃນການເລືອກຮູບທີ່ພັກ: $e')));
    }
  }

  Future<void> _pickDocumentImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90, // Higher quality for documents
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedDocumentImages.addAll(
            pickedFiles.map((file) => File(file.path)),
          );
          if (_selectedDocumentImages.length > 3) {
            _selectedDocumentImages = _selectedDocumentImages.sublist(0, 3);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ສາມາດເພີ່ມຮູບເອກະສານໄດ້ສູງສຸດ 3 ຮູບ'),
              ),
            );
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ຜິດພາດໃນການເລືອກຮູບເອກະສານ: $e')));
    }
  }

  void _removePropertyImage(int index) {
    setState(() {
      _selectedPropertyImages.removeAt(index);
    });
  }

  void _removeDocumentImage(int index) {
    setState(() {
      _selectedDocumentImages.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if property images are uploaded
    if (_selectedPropertyImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ກະລຸນາເພີ່ມຮູບພາບທີ່ພັກຢ່າງໜ້ອຍ 1 ຮູບ')),
      );
      return;
    }

    // Check if document images are uploaded
    if (_selectedDocumentImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາອັບໂຫລດເອກະສານຢັ້ງຢືນຕົວຕົນ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate network request for form submission
      await Future.delayed(const Duration(seconds: 3));

      // Here you would normally:
      // 1. Upload document images for verification
      // 2. Upload property images
      // 3. Submit form data to your backend
      // 4. Handle verification process

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('ສົ່ງຂໍ້ມູນສຳເລັດແລ້ວ! ລໍຖ້າການອະນຸມັດ'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 4),
        ),
      );

      // Show verification dialog
      _showVerificationDialog();

      // Reset form
      _resetForm();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ຜິດພາດ: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[400]!, Colors.green[600]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 60, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'ສົ່ງຂໍ້ມູນສຳເລັດ!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'ຂໍ້ມູນຂອງທ່ານໄດ້ຖືກສົ່ງໄປຫາທີມງານແລ້ວ\nລໍຖ້າການກວດສອບແລະອະນຸມັດ\nພວກເຮົາຈະແຈ້ງໃຫ້ທ່ານຊາບໃນໄວໆນີ້',
                style: TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'ເຂົ້າໃຈແລ້ວ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedPropertyImages.clear();
      _selectedDocumentImages.clear();
      _selectedCategory = "ເຮືອນ";
      _selectedStatus = "ເຊົ່າ";
      _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
      _selectedDocumentType = "ບັດປະຈຳຕົວ";
      _amenities = _amenities.map((key, value) => MapEntry(key, false));
    });

    // Clear all text controllers
    _titleController.clear();
    _priceController.clear();
    _locationController.clear();
    _descriptionController.clear();
    _phoneController.clear();
    // _areaController.clear();
    _ownerNameController.clear();
    _documentNumberController.clear();
  }
}
