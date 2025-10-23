import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/personal_info_page/widget/app_bar_section.dart';
import 'package:homefind/screens/join/pages/personal_info_page/widget/image_upload_section.dart';
import 'package:homefind/screens/join/pages/personal_info_page/widget/personal_info_form.dart';
import 'package:homefind/screens/join/pages/personal_info_page/widget/progress_indicator_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/property_details_page.dart';
import 'package:homefind/service/local_storageservice.dart';
import 'package:homefind/widgets/Colors.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _primaryColor = AppColors.color1;
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

  // State variables for images and document type
  String? _selectedDocumentType = "ບັດປະຈຳຕົວ";
  File? _selectedDocumentImage;
  File? _selectedPersonalImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
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

  // --- Data Loading and Saving Logic ---

  Future<void> _loadSavedData() async {
    try {
      final data = await LocalStorageService.loadPersonalData();

      if (data['ownerName']?.isNotEmpty ?? false) {
        setState(() {
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
          _selectedDocumentImage = base64ToFile(
            data['documentImage'],
            'document.jpg',
          );
          _selectedPersonalImage = base64ToFile(
            data['personalImage'],
            'personal.jpg',
          );
        });
      }
    } catch (e) {
      debugPrint('${S.of(context).errorLoadingSavedData}: $e');
    }
  }

  // Converts a base64 string back to a file.
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

  // Converts a file to a base64 string.
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

  // --- Main Widget Build Method ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarSection(
          title: S.of(context).personalInfo,
          onBack: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const ProgressIndicatorSection(),
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
                    // Use the ImageUploadSection widget
                    ImageUploadSection(
                      personalImage: _selectedPersonalImage,
                      onPersonalImageChanged: (file) {
                        setState(() => _selectedPersonalImage = file);
                      },
                    ),

                    const SizedBox(height: 14),
                    // Use the PersonalInfoFormFields widget
                    PersonalInfoFormFields(
                      ownerNameController: _ownerNameController,
                      ownerSurnameController: _ownerSurnameController,
                      ownerdobController: _ownerdobController,
                      villageController: _villageController,
                      districtController: _districtController,
                      cityController: _cityController,
                      documentNumberController: _documentNumberController,
                      selectedDocumentType: _selectedDocumentType,
                      onDocumentTypeChanged: (value) {
                        setState(() {
                          _selectedDocumentType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    ImageUploadSection(
                      documentImage: _selectedDocumentImage,
                      onDocumentImageChanged: (file) {
                        setState(() => _selectedDocumentImage = file);
                      },
                    ),
                    const SizedBox(height: 40),
                    _buildBottomNavigation(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets (if not extracted) and Logic ---

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
                  S.of(context).personalInfo,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
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
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              alignment: Alignment.center,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).next,
                          style: const TextStyle(
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

  Future<void> _validateAndNext() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_complete_info),
          backgroundColor: AppColors.color1,
        ),
      );
      return;
    }

    if (_selectedDocumentImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_upload_document),
          backgroundColor: AppColors.color1,
        ),
      );
      return;
    }

    if (_selectedPersonalImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_upload_personal_photo),
          backgroundColor: AppColors.color1,
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
        'personalImage': fileToBase64(_selectedPersonalImage),
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
          backgroundColor: AppColors.color1,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
