import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';

// This widget groups all the personal information and document fields.
class PersonalInfoFormFields extends StatelessWidget {
  final TextEditingController ownerNameController;
  final TextEditingController ownerSurnameController;
  final TextEditingController ownerdobController;
  final TextEditingController villageController;
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController documentNumberController;
  final String? selectedDocumentType;
  final Function(String?) onDocumentTypeChanged;

  const PersonalInfoFormFields({
    super.key,
    required this.ownerNameController,
    required this.ownerSurnameController,
    required this.ownerdobController,
    required this.villageController,
    required this.districtController,
    required this.cityController,
    required this.documentNumberController,
    required this.selectedDocumentType,
    required this.onDocumentTypeChanged,
  });

  // แก้ไข: ย้าย Map และเมธอด getDocumentTypeDisplayText เข้าไปใน build
  @override
  Widget build(BuildContext context) {
    // Map ที่เข้าถึง context ได้แล้ว
    final Map<String, String> documentTypeDisplayMap = {
      'ບັດປະຈຳຕົວ': S.of(context).idCard,
      'ໜັງສືຜ່ານແດນ': S.of(context).passport,
      'ສຳມະໂນຄົວ': S.of(context).familyBook,
    };

    // เมธอดที่เข้าถึง context ได้แล้ว
    String getDocumentTypeDisplayText(String laoValue) {
      return documentTypeDisplayMap[laoValue] ?? laoValue;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(S.of(context).personalInfo),
        const SizedBox(height: 12),
        _buildInputField(
          context,
          label: S.of(context).name,
          controller: ownerNameController,
          icon: Icons.person_outline,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_first_name
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          context,
          label: S.of(context).last_name,
          controller: ownerSurnameController,
          icon: Icons.person_outline,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_last_name
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          context,
          label: S.of(context).birth_date,
          controller: ownerdobController,
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
              ownerdobController.text = formattedDate;
            }
          },
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_birth_date
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          context,
          label: S.of(context).village,
          controller: villageController,
          icon: Icons.home_outlined,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_village
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          context,
          label: S.of(context).district,
          controller: districtController,
          icon: Icons.location_city_outlined,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_district
              : null,
        ),
        const SizedBox(height: 8),
        _buildInputField(
          context,
          label: S.of(context).province,
          controller: cityController,
          icon: Icons.map_outlined,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_province
              : null,
        ),
        const SizedBox(height: 14),
        _buildSectionTitle(S.of(context).id_document),
        const SizedBox(height: 12),
        _buildDropdownField(
          context,
          S.of(context).document_type,
          selectedDocumentType,
          ['ບັດປະຈຳຕົວ', 'ໜັງສືຜ່ານແດນ', 'ສຳມະໂນຄົວ'],
          onDocumentTypeChanged,
          Icons.credit_card_outlined,
          getDocumentTypeDisplayText, // ส่งเมธอดเข้าไปใน dropdown
        ),
        const SizedBox(height: 8),
        _buildInputField(
          context,
          label: S
              .of(context)
              .document_number_label(
                documentTypeDisplayMap[selectedDocumentType] ?? '',
              ),
          controller: documentNumberController,
          icon: Icons.numbers_outlined,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_document_number
              : null,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.color1,
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
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
            color: Colors.black.withValues(alpha: 0.05),
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
            borderSide: BorderSide(color: AppColors.color1, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: AppColors.color1),
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
    BuildContext context,
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
    IconData icon,
    String Function(String) getDocumentTypeDisplayText,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.color1, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: AppColors.color1),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: AppColors.color1),
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
}
