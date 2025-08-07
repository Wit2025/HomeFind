import 'package:flutter/material.dart';

// Transaction model class
class Transaction {
  final String id;
  final String date;
  final double amount;
  final String account;
  final String status;
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
      status: 'ສຳເລັດ',
      type: 'withdrawal',
      fee: 5.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX87654321',
      date: '2023-10-10 09:15',
      amount: 200.00,
      account: '20 ••••',
      status: 'ສຳເລັດ',
      type: 'withdrawal',
      fee: 5.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX13579246',
      date: '2023-10-05 16:45',
      amount: 75.50,
      account: '•••• 4327',
      status: 'ຍົກເລີກ',
      type: 'withdrawal',
      fee: 0.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX24681357',
      date: '2023-09-28 11:20',
      amount: 300.00,
      account: '20 ••••',
      status: 'ສຳເລັດ',
      type: 'withdrawal',
      fee: 5.00,
      method: 'ບັນຊີທະນາຄານ',
    ),
    Transaction(
      id: 'TX98765432',
      date: '2023-09-20 10:10',
      amount: 100.00,
      account: '•••• 4327',
      status: 'ລໍຖ້າຢືນຢັນ',
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ສຳເລັດ':
        return Colors.green;
      case 'ລໍຖ້າຢືນຢັນ':
        return Colors.orange;
      case 'ຍົກເລີກ':
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ປະຫວັດການຖອນເງິນ',
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
            _buildFilterButton('ທັງໝົດ', null),
            const SizedBox(width: 8),
            _buildFilterButton('ສຳເລັດ', 'ສຳເລັດ'),
            const SizedBox(width: 8),
            _buildFilterButton('ລໍຖ້າ', 'ລໍຖ້າຢືນຢັນ'),
            const SizedBox(width: 8),
            _buildFilterButton('ຍົກເລີກ', 'ຍົກເລີກ'),
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
                          '-${transaction.amount.toStringAsFixed(2)} ກີບ',
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
                            transaction.status,
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
                    'ລາຍລະອຽດການຖອນເງິນ',
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
                  '-${transaction.amount.toStringAsFixed(2)} ກີບ',
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
                    transaction.status,
                    style: TextStyle(
                      color: _getStatusColor(transaction.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Details
              _buildDetailRow('ວິທີຖອນ', transaction.method),
              _buildDetailRow('ບັນຊີປາຍທາງ', transaction.account),
              _buildDetailRow(
                'ຄ່າທຳນຽມ',
                '${transaction.fee.toStringAsFixed(2)} ກີບ',
              ),
              _buildDetailRow('ລະຫັດທຸລະກຳ', transaction.id),
              _buildDetailRow('ວັນທີ່', transaction.date),

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
                  child: const Text(
                    'ປິດ',
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ສຳເລັດ':
        return Colors.green;
      case 'ລໍຖ້າຢືນຢັນ':
        return Colors.orange;
      case 'ຍົກເລີກ':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
