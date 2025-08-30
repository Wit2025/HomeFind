class NotificationItem {
  final String id;
  final String title;
  final String details;
  final DateTime date;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.details,
    required this.date,
    this.isRead = false,
  });
}