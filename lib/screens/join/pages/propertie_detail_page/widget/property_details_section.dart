// widgets/property_details_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_fields.dart';
import 'package:intl/intl.dart';

class PropertyDetailsSection extends StatelessWidget {
  final Color primaryColor;
  final TextEditingController priceController;
  final TextEditingController brokerageController;
  final String? selectedStatus;
  final String? selectedRentalPeriod;
  final String? selectedCurrency;
  final double totalPrice;
  final NumberFormat currencyFormat;
  final Function(String?) onCurrencyChanged;

  const PropertyDetailsSection({
    super.key,
    required this.primaryColor,
    required this.priceController,
    required this.brokerageController,
    required this.selectedStatus,
    required this.selectedRentalPeriod,
    required this.selectedCurrency,
    required this.totalPrice,
    required this.currencyFormat,
    required this.onCurrencyChanged,
  });

  String _getPriceLabel(BuildContext context) {
    if (selectedStatus == 'ເຊົ່າ') {
      if (selectedRentalPeriod == 'ເປັນປີ') {
        return '${S.of(context).price_per_year} $selectedCurrency';
      } else {
        return '${S.of(context).price_per_month} $selectedCurrency';
      }
    } else {
      return '${S.of(context).price} $selectedCurrency';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).price,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        PropertyFormFields.buildDropdownField(
          S.of(context).selectCurrency,
          selectedCurrency,
          ['LAK', 'THB', 'USD', 'CNY', 'KRW'],
          onCurrencyChanged,
          Icons.currency_exchange_outlined,
          primaryColor,
        ),
        const SizedBox(height: 8),
        PropertyFormFields.buildInputField(
          label: _getPriceLabel(context),
          controller: priceController,
          icon: Icons.monetization_on_outlined,
          primaryColor: primaryColor,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) return S.of(context).please_enter_price;
            if (double.tryParse(value!) == null)
              return S.of(context).please_enter_correct_number;
            return null;
          },
        ),
        const SizedBox(height: 8),
        PropertyFormFields.buildInputField(
          label: S.of(context).commissionFee,
          controller: brokerageController,
          icon: Icons.handshake,
          primaryColor: primaryColor,
          keyboardType: TextInputType.number,
        ),
        _buildTotalPrice(context),
      ],
    );
  }

  Widget _buildTotalPrice(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.calculate, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(
            '${S.of(context).totalPrice}:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            '${currencyFormat.format(totalPrice)} $selectedCurrency',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}