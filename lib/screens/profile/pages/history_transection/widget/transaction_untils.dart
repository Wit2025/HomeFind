import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction.dart';

class TransactionUtils {
  // Function เพื่อแปลง status เป็นข้อความที่แสดงผล
  static String getStatusDisplayText(String status, BuildContext context) {
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

  static Color getStatusColor(String status) {
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

  static String getMethodDisplayText(String method, BuildContext context) {
    switch (method) {
      case 'ບັນຊີທະນາຄານ':
        return S.of(context).bank;
      default:
        return method;
    }
  }
}
