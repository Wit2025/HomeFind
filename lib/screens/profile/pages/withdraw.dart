import 'package:flutter/material.dart';

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
  String? _selectedAccountId = '4327';

  final List<Account> _accounts = [
    Account(
      id: '4327',
      name: 'ບັນຊີທະນາຄານ',
      number: '•• •••• •••• 4327',
      icon: Icons.account_balance,
    ),
  ];

  void _submitWithdrawal() {
    if (_amountController.text.trim().isEmpty || _selectedAccountId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ')));
      return;
    }

    final selectedAccount = _accounts.firstWhere(
      (a) => a.id == _selectedAccountId,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ຖອນ ${_amountController.text} ກີບ ໄປ ${selectedAccount.name} (${selectedAccount.number})',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ຖອນເງິນ',
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
              colors: [Color(0xFF57A7B1), Color(0xFF0C697A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
          const Text(
            'ຈຳນວນເງິນທີ່ຕ້ອງການຖອນ',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C697A),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              suffixText: 'ກີບ',
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
                  'ຍອດເງິນທີ່ມີ: $_availableBalance ກີບ',
                  style: const TextStyle(
                    color: Color(0xFF00CEB0),
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
              color: Color(0xFF00CEB0),
            ),
            const SizedBox(width: 8),
            const Text(
              'ຖອນເງິນໄປບັນຊີ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // TODO: Add new account
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('ເພີ່ມບັນຊີ', style: TextStyle(fontSize: 14)),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF00CEB0),
              ),
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
          color: isSelected ? const Color(0xFF00CEB0) : Colors.grey[300]!,
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
        activeColor: const Color(0xFF00CEB0),
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
          backgroundColor: const Color(0xFF0C697A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'ຢືນຢັນການຖອນເງິນ',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
