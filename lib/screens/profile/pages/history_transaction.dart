import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

// Transaction model class
class Transaction {
  final String id;
  final String date;
  final double amount;
  final String account;
  final String
  status; // เก็บเป็น key constant เช่น 'completed', 'pending', 'cancelled'
  final String type;
  final double fee;
  final String method;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.account,
    required this.status,
    required this.type,
    required this.fee,
    required this.method,
  });
}

// Status constants - ใช้เป็น internal value
class TransactionStatus {
  static const String completed = 'completed';
  static const String pending = 'pending';
  static const String cancelled = 'cancelled';
}

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
      status: TransactionStatus.completed, // ใช้ constant
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

  // Function เพื่อแปลง status เป็นข้อความที่แสดงผล
  String _getStatusDisplayText(String status, BuildContext context) {
    switch (status) {
      case TransactionStatus.completed:
        return S.of(context).completed; // ต้องเพิ่มใน l10n
      case TransactionStatus.pending:
        return S.of(context).pending; // ต้องเพิ่มใน l10n
      case TransactionStatus.cancelled:
        return S.of(context).cancelled; // ต้องเพิ่มใน l10n
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case TransactionStatus.completed: // ใช้ constant แทน
        return Colors.green;
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
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
            _buildFilterButton(S.of(context).all, null), // ต้องเพิ่มใน l10n
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
          color: isSelected ? Colors.white : const Color(0xFF0C697A),
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? status : null;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF0C697A),
      side: BorderSide(
        color: isSelected ? Colors.transparent : Colors.grey[300]!,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                child: Icon(
                  transaction.method == 'E-Wallet'
                      ? Icons.account_balance_wallet
                      : Icons.account_balance,
                  color: const Color(0xFF00CEB0),
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
                          '-${transaction.amount.toStringAsFixed(2)} ${S.of(context).kip}',
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
                            color: _getStatusColor(
                              transaction.status,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _getStatusColor(transaction.status),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            _getStatusDisplayText(
                              transaction.status,
                              context,
                            ), // ใช้ function แปลงเป็นข้อความ
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor(transaction.status),
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

class TransactionDetailDialog extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailDialog({super.key, required this.transaction});

  // Function เพื่อแปลง status เป็นข้อความที่แสดงผล
  String _getStatusDisplayText(String status, BuildContext context) {
    switch (status) {
      case TransactionStatus.completed:
        return S.of(context).completed;
      case TransactionStatus.pending:
        return S.of(context).pending;
      case TransactionStatus.cancelled:
        return S.of(context).cancelled;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case TransactionStatus.completed:
        return Colors.green;
      case TransactionStatus.pending:
        return Colors.orange;
      case TransactionStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).withdrawalDetails,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Divider
              Container(
                height: 1,
                color: Colors.grey[200],
                margin: const EdgeInsets.symmetric(vertical: 8),
              ),

              // Transaction Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F7F5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    transaction.method == 'E-Wallet'
                        ? Icons.account_balance_wallet
                        : Icons.account_balance,
                    color: const Color(0xFF00CEB0),
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Amount
              Center(
                child: Text(
                  '-${transaction.amount.toStringAsFixed(2)} ${S.of(context).kip}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C697A),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(transaction.status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(transaction.status),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getStatusDisplayText(
                      transaction.status,
                      context,
                    ), // ใช้ function แปลงเป็นข้อความ
                    style: TextStyle(
                      color: _getStatusColor(transaction.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Details
              _buildDetailRow(S.of(context).withdrawMethod, transaction.method),
              _buildDetailRow(
                S.of(context).destinationAccount,
                transaction.account,
              ),
              _buildDetailRow(
                S.of(context).fee,
                '${transaction.fee.toStringAsFixed(2)} ${S.of(context).kip}',
              ),
              _buildDetailRow(S.of(context).transactionId, transaction.id),
              _buildDetailRow(S.of(context).date, transaction.date),

              const SizedBox(height: 24),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C697A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    S.of(context).close,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
