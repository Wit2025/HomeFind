import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/account.dart';
import 'package:homefind/widgets/colors.dart';
import 'account_card.dart';

class AccountSelectionSection extends StatelessWidget {
  final List<Account> accounts;
  final String? selectedAccountId;
  final ValueChanged<String?> onAccountSelected;
  final VoidCallback onAddAccount;
  final Color primaryColor;

  const AccountSelectionSection({
    super.key,
    required this.accounts,
    required this.selectedAccountId,
    required this.onAccountSelected,
    required this.onAddAccount,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_balance_wallet_outlined,
              size: 20,
              color: AppColors.color1,
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).withdrawToAccount,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: onAddAccount,
              icon: const Icon(Icons.add, size: 16),
              label: Text(
                S.of(context).addAccount,
                style: TextStyle(fontSize: 14),
              ),
              style: TextButton.styleFrom(foregroundColor: primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...accounts.map((account) => AccountCard(
              account: account,
              selectedAccountId: selectedAccountId,
              onChanged: onAccountSelected,
              primaryColor: primaryColor,
            )),
      ],
    );
  }
}