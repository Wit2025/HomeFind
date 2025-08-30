import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction_untils.dart';
import 'package:homefind/widgets/Colors.dart';

/// Section แสดงปุ่ม filter
Widget buildFilterSection({
  required BuildContext context,
  required String? selectedFilter,
  required Function(String?) onFilterChanged,
}) {
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
          buildFilterButton(
            S.of(context).all,
            null,
            selectedFilter,
            onFilterChanged,
          ),
          const SizedBox(width: 8),
          buildFilterButton(
            S.of(context).completed,
            TransactionStatus.completed,
            selectedFilter,
            onFilterChanged,
          ),
          const SizedBox(width: 8),
          buildFilterButton(
            S.of(context).pending,
            TransactionStatus.pending,
            selectedFilter,
            onFilterChanged,
          ),
          const SizedBox(width: 8),
          buildFilterButton(
            S.of(context).cancelled,
            TransactionStatus.cancelled,
            selectedFilter,
            onFilterChanged,
          ),
        ],
      ),
    ),
  );
}

/// ปุ่มเลือก filter
Widget buildFilterButton(
  String label,
  String? status,
  String? selectedFilter,
  Function(String?) onFilterChanged,
) {
  final isSelected = selectedFilter == status;
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
        onFilterChanged(status);
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

/// แสดงเมื่อไม่มีข้อมูล
Widget buildEmptyList(BuildContext context) {
  return ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text(
            S.of(context).no_data,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ),
    ],
  );
}

/// แสดงรายการธุรกรรม
Widget buildTransactionList({
  required List<Transaction> transactions,
  required Function(Transaction) onTap,
}) {
  return ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    itemCount: transactions.length,
    separatorBuilder: (context, index) => const Divider(height: 1),
    itemBuilder: (context, index) {
      final transaction = transactions[index];
      return buildTransactionItem(context, transaction, onTap);
    },
  );
}

/// Item ธุรกรรมแต่ละตัว
Widget buildTransactionItem(
  BuildContext context,
  Transaction transaction,
  Function(Transaction) onTap,
) {
  return Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onTap(transaction),
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
                            color: TransactionUtils.getStatusColor(
                              transaction.status,
                            ),
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
                            color: TransactionUtils.getStatusColor(
                              transaction.status,
                            ),
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
