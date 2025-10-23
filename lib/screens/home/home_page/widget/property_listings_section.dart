// widgets/property_listings_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/home_page/widget/property_model.dart';
import 'package:homefind/screens/home/home_page/widget/translation_utils.dart';
import 'property_card.dart';
import 'filter_dialogs.dart';

class PropertyListingsSection extends StatelessWidget {
  final String selectedCategory;
  final String selectedStatus;
  final String? selectedPropertyType;
  final String? selectedTime;
  final String? selectedPrice;
  final List<Property> displayProperties;
  final Function(String) onStatusChanged;
  final Function(String?, String?, String?) onRentFiltersChanged;
  final Function(String?, String?) onSaleFiltersChanged;

  const PropertyListingsSection({
    super.key,
    required this.selectedCategory,
    required this.selectedStatus,
    required this.selectedPropertyType,
    required this.selectedTime,
    required this.selectedPrice,
    required this.displayProperties,
    required this.onStatusChanged,
    required this.onRentFiltersChanged,
    required this.onSaleFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [_buildListingsHeader(context), _buildPropertyGrid(context)],
      ),
    );
  }

  Widget _buildListingsHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                TranslationUtils.translateCategory(selectedCategory, context),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            _buildStatusToggle(context),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${S.of(context).found} ${displayProperties.length} ${S.of(context).listing}',
            ),
            _buildFilterButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusToggle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatusButton(context, 'ເຊົ່າ'),
        _buildStatusButton(context, 'ຂາຍ'),
      ],
    );
  }

  Widget _buildStatusButton(BuildContext context, String status) {
    bool isSelected = selectedStatus == status;
    return GestureDetector(
      onTap: () => onStatusChanged(status),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 32,
        width: 70,
        padding: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
          child: Text(TranslationUtils.translateStatus(status, context)),
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => _showFilterDialog(context),
        child: Container(
          height: 32,
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._buildActiveFilterChips(context),
                _buildFilterIcon(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActiveFilterChips(BuildContext context) {
    List<Widget> chips = [];

    if (selectedPropertyType != null && selectedPropertyType != 'ທັງໝົດ') {
      chips.add(
        _buildFilterChip(
          TranslationUtils.translateRoomSharing(selectedPropertyType!, context),
          Colors.teal,
        ),
      );
    }

    if (selectedTime != null && selectedTime != 'ທັງໝົດ') {
      chips.add(
        _buildFilterChip(
          TranslationUtils.translateTime(selectedTime!, context),
          Colors.blue,
        ),
      );
    }

    if (selectedPrice != null && selectedPrice != 'ທັງໝົດ') {
      chips.add(
        _buildFilterChip(
          TranslationUtils.translatePrice(selectedPrice!, context),
          Colors.orange,
        ),
      );
    }

    return chips;
  }

  Widget _buildFilterChip(String text, MaterialColor color) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFilterIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).filter,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 2),
          Icon(Icons.keyboard_arrow_down, size: 16),
        ],
      ),
    );
  }

  Widget _buildPropertyGrid(BuildContext context) {
    if (displayProperties.isEmpty) {
      return _buildEmptyState(context);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayProperties.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final property = displayProperties[index];
        return Transform.translate(
          offset: const Offset(0, -20),
          child: PropertyCard(property: property),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/icons/city.png', fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).no_data,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    if (selectedStatus == 'ເຊົ່າ') {
      FilterDialogs.showRentDialog(
        context,
        selectedPropertyType,
        selectedTime,
        selectedPrice,
        onRentFiltersChanged,
      );
    } else if (selectedStatus == 'ຂາຍ') {
      FilterDialogs.showSaleDialog(
        context,
        selectedTime,
        selectedPrice,
        onSaleFiltersChanged,
      );
    }
  }
}
