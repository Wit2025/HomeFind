import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

class BookingFilterWidget extends StatelessWidget {
  final String? selectedStatusFilter;
  final String? selectedTypeFilter;
  final Function(String?) onStatusFilterChanged;
  final Function(String?) onTypeFilterChanged;
  final S l10n;

  const BookingFilterWidget({
    super.key,
    required this.selectedStatusFilter,
    required this.selectedTypeFilter,
    required this.onStatusFilterChanged,
    required this.onTypeFilterChanged,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildStatusFilterButton(l10n.all, null),
            const SizedBox(width: 2),
            _buildStatusFilterButton(l10n.completed, 'ສຳເລັດ'),
            const SizedBox(width: 2),
            _buildStatusFilterButton(l10n.pending, 'ລໍຖ້າຢືນຢັນ'),
            const SizedBox(width: 2),
            _buildStatusFilterButton(l10n.cancelled, 'ຍົກເລີກ'),
            const SizedBox(width: 2),
            _buildTypeDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilterButton(String label, String? status) {
    final isSelected = selectedStatusFilter == status;
    return OutlinedButton(
      onPressed: () => onStatusFilterChanged(status),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: isSelected ? null : Colors.white,
        side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Container(
        constraints: const BoxConstraints(minWidth: 50),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.color1,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                const Icon(Icons.check, color: Colors.white, size: 16),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return Container(
      height: 32,
      constraints: const BoxConstraints(minWidth: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.color1,
        border: Border.all(
          color: selectedTypeFilter == null ? Colors.grey : AppColors.color1,
          width: 0.6,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButton<String>(
        value: selectedTypeFilter,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
          size: 20,
        ),
        elevation: 16,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(12),
        dropdownColor: Colors.white,
        selectedItemBuilder: (BuildContext context) {
          return [l10n.all, l10n.rent, l10n.sale].map<Widget>((String value) {
            return Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList();
        },
        items: <Map<String, String?>>[
          {'label': l10n.all, 'value': null},
          {'label': l10n.rent, 'value': 'ເຊົ່າ'},
          {'label': l10n.sale, 'value': 'ຂາຍ'},
        ].map<DropdownMenuItem<String>>((Map<String, String?> item) {
          return DropdownMenuItem<String>(
            value: item['value'],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                item['label']!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: onTypeFilterChanged,
        isDense: true,
      ),
    );
  }
}