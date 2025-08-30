
class Transaction {
  final String id;
  final String date;
  final double amount;
  final String account;
  final String status; // เก็บเป็น key constant เช่น 'completed', 'pending', 'cancelled'
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

class TransactionStatus {
  static const String completed = 'ສຳເລັດ';
  static const String pending = 'ລໍຖ້າດຳຢືນຢັນ';
  static const String cancelled = 'ຍົກເລີກ';
}