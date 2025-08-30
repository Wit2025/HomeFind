import 'package:flutter/material.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/account.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final String? selectedAccountId;
  final ValueChanged<String?> onChanged;
  final Color primaryColor;

  const AccountCard({
    super.key,
    required this.account,
    required this.selectedAccountId,
    required this.onChanged,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedAccountId == account.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE8F7F5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? primaryColor : Colors.grey[300]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: RadioListTile<String>(
        value: account.id,
        groupValue: selectedAccountId,
        onChanged: onChanged,
        activeColor: primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Row(
          children: [
            Icon(account.icon, size: 30, color: const Color(0xFF0C697A)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    account.number,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
