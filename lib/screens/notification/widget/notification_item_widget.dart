import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/notification/widget/notification_detail_page.dart';
import 'package:homefind/screens/notification/widget/notification_item.dart';
import 'package:homefind/widgets/Colors.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItem notification;
  final Function(String) onMarkAsRead;

  const NotificationItemWidget({
    super.key,
    required this.notification,
    required this.onMarkAsRead,
  });

  String _formatTimeAgo(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return S.of(context).daysAgo(difference.inDays.toString());
    } else if (difference.inHours > 0) {
      return S.of(context).hoursAgo(difference.inHours.toString());
    } else if (difference.inMinutes > 0) {
      return S.of(context).minutesAgo(difference.inMinutes.toString());
    } else {
      return S.of(context).justNow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.color1;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (!notification.isRead) {
            onMarkAsRead(notification.id);
          }

          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NotificationDetailPage(
                notification: notification,
                onMarkAsRead: () => onMarkAsRead(notification.id),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: !notification.isRead
                ? Border.all(color: primaryColor.withOpacity(0.3), width: 1.5)
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification icon with unread indicator
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  if (!notification.isRead)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Notification content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: !notification.isRead
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatTimeAgo(context, notification.date),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.details,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: !notification.isRead
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}