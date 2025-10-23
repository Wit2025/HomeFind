import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction_detail_dialog.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction_widgets.dart';
import 'package:homefind/widgets/colors.dart';

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

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // โหลดข้อมูลใหม่ที่นี่ (ถ้ามี API)
    });
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
          buildFilterSection(
            context: context,
            selectedFilter: _selectedFilter,
            onFilterChanged: (status) {
              setState(() {
                _selectedFilter = status;
              });
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.color1,
              onRefresh: _handleRefresh,
              child: _filteredTransactions.isEmpty
                  ? buildEmptyList(context)
                  : buildTransactionList(
                      transactions: _filteredTransactions,
                      onTap: _showTransactionDetails,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
