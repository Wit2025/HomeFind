// widgets/property_basic_info_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_fields.dart';

class PropertyBasicInfoSection extends StatelessWidget {
  final Color primaryColor;
  final TextEditingController titleController;
  final String? selectedStatus;
  final String? selectedRentalPeriod;
  final String? selectedRoomSharing;
  final Function(String?) onStatusChanged;
  final Function(String?) onRentalPeriodChanged;
  final Function(String?) onRoomSharingChanged;

  const PropertyBasicInfoSection({
    super.key,
    required this.primaryColor,
    required this.titleController,
    required this.selectedStatus,
    required this.selectedRentalPeriod,
    required this.selectedRoomSharing,
    required this.onStatusChanged,
    required this.onRentalPeriodChanged,
    required this.onRoomSharingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).basic_info,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 8),
        PropertyFormFields.buildInputField(
          label: S.of(context).accommodation_name,
          controller: titleController,
          icon: Icons.title_outlined,
          primaryColor: primaryColor,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_accommodation_name
              : null,
        ),
        const SizedBox(height: 8),
        PropertyFormFields.buildTranslatableDropdownField(
          context,
          S.of(context).status,
          selectedStatus,
          ['ເຊົ່າ', 'ຂາຍ'],
          onStatusChanged,
          Icons.sell_outlined,
          primaryColor,
        ),
        const SizedBox(height: 8),
        if (selectedStatus == 'ເຊົ່າ') ...[
          PropertyFormFields.buildTranslatableDropdownField(
            context,
            S.of(context).rental_period,
            selectedRentalPeriod,
            ['ເປັນເດືອນ', 'ເປັນປີ'],
            onRentalPeriodChanged,
            Icons.schedule_outlined,
            primaryColor,
          ),
          const SizedBox(height: 8),
          PropertyFormFields.buildTranslatableDropdownField(
            context,
            S.of(context).share_room,
            selectedRoomSharing,
            ['ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
            onRoomSharingChanged,
            Icons.people_outlined,
            primaryColor,
          ),
        ],
      ],
    );
  }
}