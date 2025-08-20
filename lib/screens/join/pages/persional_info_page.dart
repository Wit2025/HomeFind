import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/property_details_page.dart';
import 'package:homefind/service/local_storageService.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _primaryColor = AppColors.color1;
  final _darkPrimaryColor = AppColors.color2;
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

  // Document type mapping for display
  Map<String, String> get documentTypeDisplayMap {
    return {
      'ບັດປະຈຳຕົວ': S.of(context).idCard,
      'ໜັງສືຜ່ານແດນ': S.of(context).passport,
      'ສຳມະໂນຄົວ': S.of(context).familyBook,
    };
  }

  // Get display text for document type
  String getDocumentTypeDisplayText(String laoValue) {
    return documentTypeDisplayMap[laoValue] ?? laoValue;
  }

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
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    try {
      final data = await LocalStorageService.loadPersonalData();

      if (data['ownerName']?.isNotEmpty ?? false) {
        // Load text fields
        _ownerNameController.text = data['ownerName']!;
        _ownerSurnameController.text = data['ownerSurname']!;
        _ownerdobController.text = data['ownerdob']!;
        _villageController.text = data['village']!;
        _districtController.text = data['district']!;
        _cityController.text = data['city']!;
        _selectedDocumentType = data['documentType']!;
        _documentNumberController.text = data['documentNumber']!;

        // Load images from base64 strings
        if (data['documentImage']?.isNotEmpty ?? false) {
          _selectedDocumentImage = base64ToFile(
            data['documentImage'],
            'document.jpg',
          );
        }

        if (data['personalImage']?.isNotEmpty ?? false) {
          _selectedPersonalImage = base64ToFile(
            data['personalImage'],
            'personal.jpg',
          );
        }

        // Update UI
        if (mounted) setState(() {});
      }
    } catch (e) {
      debugPrint('${S.of(context).errorLoadingSavedData}: $e');
    }
  }

  // convert file to base64 string
  File? base64ToFile(String? base64String, String filename) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      final bytes = base64Decode(base64String);
      final tempDir = Directory.systemTemp;
      final file = File('${tempDir.path}/$filename');
      file.writeAsBytesSync(bytes);
      return file;
    } catch (e) {
      debugPrint('${S.of(context).errorConvertingBase64ToFile}: $e');
      return null;
    }
  }

  String fileToBase64(File? file) {
    if (file == null) return '';
    try {
      final bytes = file.readAsBytesSync();
      return base64Encode(bytes);
    } catch (e) {
      debugPrint('${S.of(context).errorConvertingFileToBase64}: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
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
      title: Text(
        // 'ຂໍ້ມູນສ່ວນຕົວ',
        S.of(context).personalInfo,
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
              Expanded(
                child: Text(
                  // 'ຂໍ້ມູນສ່ວນຕົວ',
                  S.of(context).personalInfo,
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
            // 'ກະລຸນາປ້ອນຂໍ້ມູນສ່ວນຕົວຂອງທ່ານໃຫ້ຄົບຖ້ວນ ເພື່ອການຢັ້ງຢືນຕົວຕົນ',
            S.of(context).please_enter_personal_info,
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
        Text(
          // 'ອັບໂຫຼດຮູບຖ່າຍ',
          S.of(context).upload_photo,
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
            // 'ອັບໂຫຼດຮູບຖ່າຍຂອງທ່ານໃນປັດຈຸບັນ',
            S.of(context).upload_current_photo,
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
          // 'ແຕະເພື່ອອັບໂຫຼດຮູບ',
          S.of(context).tap_to_upload,
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
          child: _selectedPersonalImage != null
              ? Image.file(
                  _selectedPersonalImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Container(color: Colors.grey[200]),
        ),
        if (_selectedPersonalImage != null)
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: _removePersonalImage,
              icon: Icon(Icons.close, color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildDocumentUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'ຮູບເອກະສານ',
          S.of(context).document_photo,
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
            // 'ອັບໂຫຼດຮູບເອກະສານທີ່ສະແດງຕົວຕົນ',
            S.of(context).upload_id_document,
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
          // 'ອັບໂຫຼດຮູບເອກະສານ',
          S.of(context).upload_document,
          style: TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          // 'ແຕະເພື່ອອັບໂຫຼດຮູບເອກະສານ',
          S.of(context).tap_to_upload_document,
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
          child: _selectedDocumentImage != null
              ? Image.file(
                  _selectedDocumentImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Container(color: Colors.grey[200]),
        ),
        if (_selectedDocumentImage != null)
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: _removeDocumentImage,
              icon: Icon(Icons.close, color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'ຂໍ້ມູນສ່ວນຕົວ',
          S.of(context).personalInfo,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        _buildInputField(
          // label: 'ຊື່',
          label: S.of(context).name,
          controller: _ownerNameController,
          icon: Icons.person_outline,
          // validator: (value) => value?.isEmpty ?? true ? ກະລຸນາປ້ອນຊື່ : null,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_first_name
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          // label: 'ນາມສະກຸນ',
          label: S.of(context).last_name,
          controller: _ownerSurnameController,
          icon: Icons.person_outline,
          validator: (value) =>
              // value?.isEmpty ?? true ? ກະລຸນາປ້ອນນາມສະກຸນ : null,
              value?.isEmpty ?? true
              ? S.of(context).please_enter_last_name
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          // label: 'ວັນ,ເດືອນ,ປີເກີດ',
          label: S.of(context).birth_date,
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
              // value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນວັນ,ເດືອນ,ປີເກີດ' : null,
              value?.isEmpty ?? true
              ? S.of(context).please_enter_birth_date
              : null,
        ),

        const SizedBox(height: 8),
        _buildInputField(
          // label: 'ບ້ານ',
          label: S.of(context).village,
          controller: _villageController,
          icon: Icons.home_outlined,
          validator: (value) =>
              // value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນຊື່ບ້ານ' : null,
              value?.isEmpty ?? true
              ? S.of(context).please_enter_village
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          // label: 'ເມືອງ',
          label: S.of(context).district,
          controller: _districtController,
          icon: Icons.location_city_outlined,
          validator: (value) =>
              // value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນຊື່ເມືອງ' : null,
              value?.isEmpty ?? true
              ? S.of(context).please_enter_district
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          // label: 'ແຂວງ',
          label: S.of(context).province,
          controller: _cityController,
          icon: Icons.map_outlined,
          validator: (value) =>
              // value?.isEmpty ?? true ? 'ກະລຸນາປ້ອນຊື່ແຂວງ' : null,
              value?.isEmpty ?? true
              ? S.of(context).please_enter_province
              : null,
        ),
      ],
    );
  }

  Widget _buildDocumentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'ເອກະສານຢັ້ງຢືນຕົວຕົນ',
          S.of(context).id_document,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        _buildDropdownField(
          // 'ປະເພດເອກະສານ',
          S.of(context).document_type,
          _selectedDocumentType,
          ['ບັດປະຈຳຕົວ', 'ໜັງສືຜ່ານແດນ', 'ສຳມະໂນຄົວ'],
          (value) => setState(() => _selectedDocumentType = value),
          Icons.credit_card_outlined,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          label: S
              .of(context)
              .document_number_label(
                documentTypeDisplayMap[_selectedDocumentType] ?? '',
              ),
          controller: _documentNumberController,
          icon: Icons.numbers_outlined,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_document_number
              : null,
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
              return DropdownMenuItem<String>(
                value: item,
                child: Text(getDocumentTypeDisplayText(item)),
              );
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
            padding:
                EdgeInsets.zero, // ต้องเพิ่มบรรทัดนี้เพื่อให้ gradient เต็มปุ่ม
            backgroundColor: Colors.transparent, // ตั้งค่าเป็น transparent
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.color1, AppColors.color2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).next,
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
          // content: Text('ຜິດພາດໃນການເລືອກຮູບ: $e'),
          content: Text('${S.of(context).image_selection_error}: $e'),
          backgroundColor: Color.fromARGB(255, 12, 105, 122),
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
          content: Text('${S.of(context).image_selection_error}: $e'),
          backgroundColor: Color.fromARGB(255, 12, 105, 122),
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
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        // const SnackBar(content: Text('ກະລຸນາກໍ່ນຂໍ້ມູນໃຫ້ຄົບຖ້ວນ')),
        SnackBar(
          content: Text(S.of(context).please_complete_info),
          backgroundColor: Color.fromARGB(255, 12, 105, 122),
        ),
      );
      return;
    }

    if (_selectedDocumentImage == null) {
      ScaffoldMessenger.of(
        context,
        // ).showSnackBar(const SnackBar(content: Text('ກະລຸນາອັບໂຫຼດຮູບເອກະສານ')));
      ).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_upload_document),
          backgroundColor: Color.fromARGB(255, 12, 105, 122),
        ),
      );
      return;
    }

    if (_selectedPersonalImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        // const SnackBar(content: Text('ກະລຸນາອັບໂຫຼດຮູບຖ່າຍສ່ວນຕົວ')),
        SnackBar(
          content: Text(S.of(context).please_upload_personal_photo),
          backgroundColor: Color.fromARGB(255, 12, 105, 122),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final personalData = {
        'ownerName': _ownerNameController.text,
        'ownerSurname': _ownerSurnameController.text,
        'ownerdob': _ownerdobController.text,
        'village': _villageController.text,
        'district': _districtController.text,
        'city': _cityController.text,
        'documentType': _selectedDocumentType!,
        'documentNumber': _documentNumberController.text,
        'documentImage': fileToBase64(_selectedDocumentImage),
        'personalImage': fileToBase64(
          _selectedPersonalImage,
        ), // Make sure this is included
      };

      await LocalStorageService.savePersonalData(personalData);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PropertyDetailsPage(personalData: personalData),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Color.fromARGB(255, 12, 105, 122),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
