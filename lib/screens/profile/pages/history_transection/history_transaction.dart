import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction_detail_dialog.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction_untils.dart';
import 'package:homefind/widgets/Colors.dart';

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({super.key});

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  final List<Transaction> _allTransactions = [
    Transaction(
      id: 'TX12345678',
      date: '2023-10-15 14:30',
      amount: 150.00,
      account: '•••• 4327',
      status: TransactionStatus.completed,
      type: 'withdrawal',
      fee: 5.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX87654321',
      date: '2023-10-10 09:15',
      amount: 200.00,
      account: '20 ••••',
      status: TransactionStatus.completed,
      type: 'withdrawal',
      fee: 5.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX13579246',
      date: '2023-10-05 16:45',
      amount: 75.50,
      account: '•••• 4327',
      status: TransactionStatus.cancelled,
      type: 'withdrawal',
      fee: 0.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX24681357',
      date: '2023-09-28 11:20',
      amount: 300.00,
      account: '20 ••••',
      status: TransactionStatus.completed,
      type: 'withdrawal',
      fee: 5.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX98765432',
      date: '2023-09-20 10:10',
      amount: 100.00,
      account: '•••• 4327',
      status: TransactionStatus.pending,
      type: 'withdrawal',
      fee: 5.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
  ];

  String? _selectedFilter;
  List<Transaction> get _filteredTransactions {
    if (_selectedFilter == null) return _allTransactions;
    return _allTransactions.where((t) => t.status == _selectedFilter).toList();
  }

  void _showTransactionDetails(Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) => TransactionDetailDialog(transaction: transaction),
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
          S.of(context).withdrawalHistory,
          style: const TextStyle(
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
      body: Column(
        children: [
          // Filter Section
          _buildFilterSection(),
          const SizedBox(height: 8),

          // Transaction List
          _buildTransactionList(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterButton(S.of(context).all, null),
            const SizedBox(width: 8),
            _buildFilterButton(
              S.of(context).completed,
              TransactionStatus.completed,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              S.of(context).pending,
              TransactionStatus.pending,
            ),
            const SizedBox(width: 8),
            _buildFilterButton(
              S.of(context).cancelled,
              TransactionStatus.cancelled,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, String? status) {
    final isSelected = _selectedFilter == status;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (!isSelected) {
          setState(() {
            _selectedFilter = status;
          });
        }
      },
      backgroundColor: Colors.white,
      selectedColor: AppColors.color1,
      side: BorderSide(
        color: isSelected ? Colors.transparent : Colors.grey[300]!,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          // TODO: Add refresh functionality
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: _filteredTransactions.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final transaction = _filteredTransactions[index];
            return _buildTransactionItem(transaction);
          },
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _showTransactionDetails(transaction),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F7F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance,
                  color: AppColors.color1,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '-₭ ${transaction.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: TransactionUtils.getStatusColor(
                              transaction.status,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: TransactionUtils.getStatusColor(transaction.status),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            TransactionUtils.getStatusDisplayText(
                              transaction.status,
                              context,
                            ),
                            style: TextStyle(
                              fontSize: 10,
                              color: TransactionUtils.getStatusColor(transaction.status),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      transaction.account,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      transaction.date,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}