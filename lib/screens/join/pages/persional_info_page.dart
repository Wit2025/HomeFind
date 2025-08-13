import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homefind/screens/join/pages/property_details_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _primaryColor = const Color.fromARGB(255, 87, 167, 177);
  final _darkPrimaryColor = const Color.fromARGB(255, 12, 105, 122);
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerSurnameController = TextEditingController();
  final TextEditingController _ownerdobController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _documentNumberController =
      TextEditingController();

  // State variables
  String? _selectedDocumentType = "ບັດປະຈຳຕົວ";
  File? _selectedDocumentImage;
  File? _selectedPersonalImage; // Add personal photo
  bool _isLoading = false;

  @override
  void dispose() {
    _ownerNameController.dispose();
    _ownerSurnameController.dispose();
    _ownerdobController.dispose();
    _villageController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _documentNumberController.dispose();
    super.dispose();
  }

  // save to local storage
  //   Future<void> savePersonalInfoStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isPersonalInfoFilled', true);
  // }
  Future<void> savePersonalData(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString('personalData', jsonString);
    await prefs.setBool('isPersonalInfoFilled', true);
  }

  // show personalInfo
  Future<Map<String, dynamic>?> loadPersonalData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('personalData');
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  @override
  void initState() {
    super.initState();
    loadPersonalData().then((data) {
      if (data != null) {
        _ownerNameController.text = data['ownerName'] ?? '';
        _ownerSurnameController.text = data['ownerSurname'] ?? '';
        _ownerdobController.text = data['ownerdob'] ?? '';
        _villageController.text = data['village'] ?? '';
        _districtController.text = data['district'] ?? '';
        _cityController.text = data['city'] ?? '';
        _selectedDocumentType = data['documentType'] ?? '';
        _documentNumberController.text = data['documentNumber'] ?? '';
        _selectedDocumentImage = data['documentImage'] ?? '';
        setState(() {});
      }
    });
  }
  
  // convert file to base64 string
  String fileToBase64(File? file) {
  if (file == null) return '';
  final bytes = file.readAsBytesSync();
  return base64Encode(bytes);
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
                    _buildPersonalPhotoSection(),
                    const SizedBox(height: 14),
                    _buildPersonalInfoSection(),
                    const SizedBox(height: 14),
                    _buildDocumentSection(),
                    const SizedBox(height: 14),
                    _buildDocumentUploadSection(),
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
        'ຂໍ້ມູນສ່ວນຕົວ',
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
          // Step 1 - Active
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
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
          Container(
            height: 2,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          // Step 2 - Inactive
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.home, color: Colors.grey[600], size: 20),
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
                  Icons.person_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'ຂໍ້ມູນສ່ວນຕົວ',
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
            'ກະລຸນາປ້ອນຂໍ້ມູນສ່ວນຕົວຂອງທ່ານໃຫ້ຄົບຖ້ວນ ເພື່ອການຢັ້ງຢືນຕົວຕົນ',
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

  Widget _buildPersonalPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ອັບໂຫຼດຮູບຖ່າຍ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: _pickPersonalImage,
            child: Container(
              width: 280,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedPersonalImage != null
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
              child: _selectedPersonalImage == null
                  ? _buildEmptyPersonalPhotoPlaceholder()
                  : _buildPersonalImageDisplay(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'ອັບໂຫຼດຮູບຖ່າຍຂອງທ່ານໃນປັດຈຸບັນ',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyPersonalPhotoPlaceholder() {
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

  Widget _buildPersonalImageDisplay() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.file(_selectedPersonalImage!, fit: BoxFit.cover),
          ),
        ),

        // Remove button
        if (_selectedPersonalImage != null)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _removePersonalImage,
                icon: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDocumentUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ຮູບເອກະສານ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: _pickDocumentImage,
            child: Container(
              width: 280,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedDocumentImage != null
                      ? _primaryColor
                      : Colors.grey[300]!,
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
              child: _selectedDocumentImage == null
                  ? _buildEmptyDocumentPlaceholder()
                  : _buildDocumentImageDisplay(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'ອັບໂຫຼດຮູບເອກະສານທີ່ສະແດງຕົວຕົນ',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyDocumentPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.credit_card_outlined, size: 40, color: _primaryColor),
        const SizedBox(height: 8),
        Text(
          'ອັບໂຫຼດຮູບເອກະສານ',
          style: TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'ແຕະເພື່ອອັບໂຫຼດຮູບເອກະສານ',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDocumentImageDisplay() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.file(
            _selectedDocumentImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Edit button
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   child: Container(
        //     height: 35,
        //     width: 35,
        //     decoration: BoxDecoration(
        //       color: Colors.black.withOpacity(0.7),
        //       shape: BoxShape.circle,
        //     ),
        //     child: IconButton(
        //       onPressed: _pickDocumentImage,
        //       icon: const Icon(Icons.edit, color: Colors.white, size: 20),
        //     ),
        //   ),
        // ),
        // Remove button
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 35,
            width: 35,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _removeDocumentImage,
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ຂໍ້ມູນສ່ວນຕົວ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        _buildInputField(
          label: 'ຊື່',
          controller: _ownerNameController,
          icon: Icons.person_outline,
          validator: (value) => value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນຊື່' : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: 'ນາມສະກຸນ',
          controller: _ownerSurnameController,
          icon: Icons.person_outline,
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນນາມສະກຸນ' : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: 'ວັນ,ເດືອນ,ປີເກີດ',
          controller: _ownerdobController,
          icon: Icons.calendar_today,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
              _ownerdobController.text = formattedDate;
            }
          },
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນວັນ,ເດືອນ,ປີເກີດ' : null,
        ),

        const SizedBox(height: 8),
        _buildInputField(
          label: 'ບ້ານ',
          controller: _villageController,
          icon: Icons.home_outlined,
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນຊື່ບ້ານ' : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: 'ເມືອງ',
          controller: _districtController,
          icon: Icons.location_city_outlined,
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນຊື່ເມືອງ' : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: 'ແຂວງ',
          controller: _cityController,
          icon: Icons.map_outlined,
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນຊື່ແຂວງ' : null,
        ),
      ],
    );
  }

  Widget _buildDocumentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ເອກະສານຢັ້ງຢືນຕົວຕົນ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        _buildDropdownField(
          'ປະເພດເອກະສານ',
          _selectedDocumentType,
          ['ບັດປະຈຳຕົວ', 'ໜັງສືຜ່ານແດນ', 'ສຳມະໂນຄົວ'],
          (value) => setState(() => _selectedDocumentType = value),
          Icons.credit_card_outlined,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: 'ເລກທີເອກະສານ',
          controller: _documentNumberController,
          icon: Icons.numbers_outlined,
          validator: (value) =>
              value?.isEmpty ?? true ? 'ກະລຸນາໃສ່ເລກທີເອກະສານ' : null,
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
    VoidCallback? onTap,
    bool readOnly = false,
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
        readOnly: readOnly,
        onTap: onTap,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _validateAndNext,
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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ຖັດໄປ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _pickPersonalImage() async {
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
          _selectedPersonalImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ຜິດພາດໃນການເລືອກຮູບ: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removePersonalImage() {
    setState(() {
      _selectedPersonalImage = null;
    });
  }

  Future<void> _pickDocumentImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedDocumentImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ຜິດພາດໃນການເລືອກຮູບ: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeDocumentImage() {
    setState(() {
      _selectedDocumentImage = null;
    });
  }

  Future<void> _validateAndNext() async {
    Map<String, String> personalData = {
      'ownerName': _ownerNameController.text,
      'ownerSurname': _ownerSurnameController.text,
      'ownerdob': _ownerdobController.text,
      'village': _villageController.text,
      'district': _districtController.text,
      'city': _cityController.text,
      'documentType': _selectedDocumentType!,
      'documentNumber': _documentNumberController.text,
      'documentImage': fileToBase64(_selectedDocumentImage),
    };
    // await savePersonalInfoStatus();
    await savePersonalData(personalData);
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາກໍ່ນຂໍ້ມູນໃຫ້ຄົບຖ້ວນ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedDocumentImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາອັບໂຫຼດຮູບເອກະສານ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedPersonalImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ກະລຸນາອັບໂຫຼດຮູບຖ່າຍສ່ວນຕົວ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    // Navigate to property details page
    // You need to import PropertyDetailsPage or create the navigation here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetailsPage(
          personalData: {
            'ownerName': _ownerNameController.text,
            'ownerSurname': _ownerSurnameController.text,
            'ownerdob': _ownerdobController.text,
            'village': _villageController.text,
            'district': _districtController.text,
            'city': _cityController.text,
            'documentType': _selectedDocumentType,
            'documentNumber': _documentNumberController.text,
            'documentImage': _selectedDocumentImage,
          },
        ),
      ),
    );
  }
}