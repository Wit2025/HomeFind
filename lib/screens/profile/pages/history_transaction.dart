import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:flutter/services.dart';

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
  static const String completed = 'ສຳເລັດ';
  static const String pending = 'ລໍຖ້າດຳຢືນຢັນ';
  static const String cancelled = 'ຍົກເລີກ';
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
                child: Icon(
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

  String _getMethodDisplayText(String method, BuildContext context) {
    switch (method) {
      case 'ບັນຊີທະນາຄານ':
        return S.of(context).bank;
      default:
        return method;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [_buildTransactionIcon(), _buildContent(context)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.color1, AppColors.color2],
        ),
        borderRadius: BorderRadius.zero,
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(child: CustomPaint(painter: DotPatternPainter())),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Title in center
                Text(
                  S.of(context).withdrawalDetails,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                // Close button on the left
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionIcon() {
    return Transform.translate(
      offset: const Offset(0, -35),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.color1, AppColors.color1.withOpacity(0.8)],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.color1.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(Icons.account_balance, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          // Amount Section
          _buildAmountSection(context),
          const SizedBox(height: 32),

          // Details Section
          _buildDetailsSection(context),
          const SizedBox(height: 32),

          // Close button
          _buildCloseButton(context),
          const SizedBox(height: 32), // เพิ่ม space ท้าย
        ],
      ),
    );
  }

  Widget _buildAmountSection(BuildContext context) {
    return Column(
      children: [
        Text(
          '- ₭ ${transaction.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C697A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _getStatusColor(transaction.status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _getStatusColor(transaction.status).withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _getStatusColor(transaction.status).withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            _getStatusDisplayText(transaction.status, context),
            style: TextStyle(
              color: _getStatusColor(transaction.status),
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            S.of(context).withdrawMethod,
            _getMethodDisplayText(transaction.method, context), // เพิ่ม context
          ),
          _buildDetailRow(
            S.of(context).destinationAccount,
            transaction.account,
          ),
          _buildDetailRow(
            S.of(context).fee,
            '₭ ${transaction.fee.toStringAsFixed(2)}',
          ),
          _buildDetailRow(S.of(context).transactionId, transaction.id),
          _buildDetailRow(S.of(context).date, transaction.date, isLast: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.color1.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                S.of(context).close,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter for dot pattern background
class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    const spacing = 20.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
