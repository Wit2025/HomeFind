import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

// Account model class
class Account {
  final String id;
  final String name;
  final String number;
  final IconData icon;

  Account({
    required this.id,
    required this.name,
    required this.number,
    required this.icon,
  });
}

class WithdrawPages extends StatefulWidget {
  const WithdrawPages({super.key});

  @override
  State<WithdrawPages> createState() => _WithdrawPagesState();
}

class _WithdrawPagesState extends State<WithdrawPages> {
  final TextEditingController _amountController = TextEditingController(
    text: '',
  );
  final double _availableBalance = 458.78;
  final _primarycolor = AppColors.color1;
  String? _selectedAccountId = '4327';

  List<Account> _accounts = [
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
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).completed,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '₭ ${S.of(context).withdrawMoney} ${_amountController.text}',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 12, 105, 122),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // ปิด Dialog
                    _amountController.clear(); // ล้างข้อมูลใน _amountController
                  },
                  child: Text(
                    S.of(context).understood,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddAccountForm() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _buildAddAccountDialog(),
    );
  }

  Widget _buildAddAccountDialog() {
    final TextEditingController accountNameController = TextEditingController();
    final TextEditingController accountNumberController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: _primarycolor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        S.of(context).addAccount,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        padding: EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Account Name Field
                Text(
                  S.of(context).accountName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: accountNameController,
                  decoration: InputDecoration(
                    hintText: S.of(context).accountNameHint,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: _primarycolor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _primarycolor),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.of(context).accountNameValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Account Number Field
                Text(
                  S.of(context).accountNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: accountNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: S.of(context).accountNumberHint,
                    prefixIcon: Icon(Icons.credit_card, color: _primarycolor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _primarycolor),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.of(context).accountNumberValidation;
                    }
                    if (value.length < 10) {
                      return '${S.of(context).accountNumberMinLength} 10 ${S.of(context).digits}';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          S.of(context).cancel,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _addNewAccount(
                              accountNameController.text.trim(),
                              accountNumberController.text.trim(),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, // ต้องเพิ่มบรรทัดนี้
                          backgroundColor:
                              Colors.transparent, // เปลี่ยนเป็น transparent
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.color1,
                                AppColors.color2,
                              ], // ใช้สีจาก AppColors
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                            ), // เก็บ padding เดิม
                            child: Center(
                              child: Text(
                                S.of(context).addAccount,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addNewAccount(String accountName, String accountNumber) {
    // Format account number to show only last 4 digits
    String maskedNumber = _maskAccountNumber(accountNumber);

    // Generate unique ID
    String newId = DateTime.now().millisecondsSinceEpoch.toString();

    Account newAccount = Account(
      id: newId,
      name: accountName,
      number: maskedNumber,
      icon: Icons.account_balance,
    );

    setState(() {
      _accounts.add(newAccount);
      _selectedAccountId = newId; // Auto-select the new account
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
            // Amount Input Section
            _buildAmountInputSection(),
            const SizedBox(height: 32),

            // Account Selection Section
            _buildAccountSelectionSection(),
            const SizedBox(height: 24),

            // Withdraw Button
            _buildWithdrawButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInputSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            S.of(context).amountToWithdraw,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              suffixText: '₭',
              suffixStyle: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            onChanged: (value) => _formatNumber(value),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F7F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${S.of(context).availableBalance}: ₭ $_availableBalance',
                  style: const TextStyle(
                    color: AppColors.color1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSelectionSection() {
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
              onPressed: _showAddAccountForm,
              icon: const Icon(Icons.add, size: 16),
              label: Text(
                S.of(context).addAccount,
                style: TextStyle(fontSize: 14),
              ),
              style: TextButton.styleFrom(foregroundColor: _primarycolor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._accounts.map((account) => _buildAccountCard(account)),
      ],
    );
  }

  Widget _buildAccountCard(Account account) {
    final isSelected = _selectedAccountId == account.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE8F7F5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? _primarycolor : Colors.grey[300]!,
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
        groupValue: _selectedAccountId,
        onChanged: (value) => setState(() => _selectedAccountId = value),
        activeColor: _primarycolor,
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

  Widget _buildWithdrawButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _submitWithdrawal,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // ต้องเพิ่มบรรทัดนี้
          backgroundColor: Colors.transparent, // เปลี่ยนเป็น transparent
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.color2,
              ], // ใช้สีจาก AppColors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ), // ปรับ padding ให้เหมาะสม
            child: Center(
              child: Text(
                S.of(context).confirmWithdrawal,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _formatNumber(String value) {
    if (value.isEmpty) return;

    // Remove all non-digit characters except decimal point
    String cleanValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    // Handle multiple decimal points
    if (cleanValue.split('.').length > 2) {
      cleanValue = cleanValue.substring(0, cleanValue.length - 1);
    }

    // Split into whole and decimal parts
    List<String> parts = cleanValue.split('.');
    String wholePart = parts[0];
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    // Add thousand separators
    String formatted = '';
    for (int i = 0; i < wholePart.length; i++) {
      if ((wholePart.length - i) % 3 == 0 && i != 0) {
        formatted += ',';
      }
      formatted += wholePart[i];
    }

    // Update the controller
    _amountController.value = TextEditingValue(
      text: '$formatted$decimalPart',
      selection: TextSelection.collapsed(
        offset: '$formatted$decimalPart'.length,
      ),
    );
  }
}
