import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/account.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/account_selection_section.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/add_account_dialog.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/amount_input_section.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/gradient_button.dart';
import 'package:homefind/screens/profile/pages/withdraw/widget/success_dialog.dart';
import 'package:homefind/widgets/colors.dart';


class WithdrawPages extends StatefulWidget {
  const WithdrawPages({super.key});

  @override
  State<WithdrawPages> createState() => _WithdrawPagesState();
}

class _WithdrawPagesState extends State<WithdrawPages> {
  final TextEditingController _amountController = TextEditingController(text: '');
  final double _availableBalance = 458.78;
  final _primarycolor = AppColors.color1;
  String? _selectedAccountId = '4327';

  final List<Account> _accounts = [
    Account(
      id: '4327',
      name: 'ຊື່ບັນຊີທະນາຄານ',
      number: '•• •••• •••• 4327',
      icon: Icons.account_balance,
    ),
  ];

  void _submitWithdrawal() {
    if (_amountController.text.trim().isEmpty || _selectedAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).pleaseEnterCompleteData),
          backgroundColor: Color.fromARGB(255, 87, 167, 177),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessDialog(
        amount: _amountController.text,
        onConfirm: () {
          Navigator.of(context).pop();
          _amountController.clear();
        },
      ),
    );
  }

  void _showAddAccountForm() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddAccountDialog(
        onAddAccount: _addNewAccount,
        primaryColor: _primarycolor,
      ),
    );
  }

  void _addNewAccount(String accountName, String accountNumber) {
    String maskedNumber = _maskAccountNumber(accountNumber);
    String newId = DateTime.now().millisecondsSinceEpoch.toString();

    Account newAccount = Account(
      id: newId,
      name: accountName,
      number: maskedNumber,
      icon: Icons.account_balance,
    );

    setState(() {
      _accounts.add(newAccount);
      _selectedAccountId = newId;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).accountAddedSuccess),
        backgroundColor: Color.fromARGB(255, 87, 167, 177),
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) {
      return accountNumber;
    }

    String lastFour = accountNumber.substring(accountNumber.length - 4);
    String masked = '•• •••• •••• $lastFour';

    return masked;
  }

  void _formatNumber(String value) {
    if (value.isEmpty) return;

    String cleanValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    if (cleanValue.split('.').length > 2) {
      cleanValue = cleanValue.substring(0, cleanValue.length - 1);
    }

    List<String> parts = cleanValue.split('.');
    String wholePart = parts[0];
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    String formatted = '';
    for (int i = 0; i < wholePart.length; i++) {
      if ((wholePart.length - i) % 3 == 0 && i != 0) {
        formatted += ',';
      }
      formatted += wholePart[i];
    }

    _amountController.value = TextEditingValue(
      text: '$formatted$decimalPart',
      selection: TextSelection.collapsed(
        offset: '$formatted$decimalPart'.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context).withdrawMoney,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            AmountInputSection(
              amountController: _amountController,
              availableBalance: _availableBalance,
              onChanged: _formatNumber,
            ),
            const SizedBox(height: 32),
            AccountSelectionSection(
              accounts: _accounts,
              selectedAccountId: _selectedAccountId,
              onAccountSelected: (value) => setState(() => _selectedAccountId = value),
              onAddAccount: _showAddAccountForm,
              primaryColor: _primarycolor,
            ),
            const SizedBox(height: 24),
            GradientButton(
              text: S.of(context).confirmWithdrawal,
              onPressed: _submitWithdrawal,
            ),
          ],
        ),
      ),
    );
  }
}