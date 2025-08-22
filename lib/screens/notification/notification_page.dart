import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

// Notification Tab constants
class NotificationTabs {
  static const String unread = 'ຍັງບໍ່ອ່ານ';
  static const String read = 'ອ່ານແລ້ວ';
}

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

class NotificationsBody extends StatefulWidget {
  const NotificationsBody({super.key});

  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  final _primaryColor = AppColors.color1;
  // ignore: unused_field
  final _darkPrimaryColor = AppColors.color2;
  final _scrollController = ScrollController();

  String _selectedTab = NotificationTabs.unread; // ใช้ constant แทน
  List<NotificationItem> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function เพื่อแปลง tab เป็นข้อความที่แสดงผล
  String _getTabDisplayText(String tab) {
    switch (tab) {
      case NotificationTabs.unread:
        return S.of(context).unread; // ต้องเพิ่มใน l10n
      case NotificationTabs.read:
        return S.of(context).read; // ต้องเพิ่มใน l10n
      default:
        return tab;
    }
  }

  void _loadNotifications() {
    // Mock data - in a real app, this would come from an API
    setState(() {
      _notifications = [
        NotificationItem(
          id: '1',
          title: 'ທອງດີ ສີສະຫວັດ',
          details: 'ໄດ້ເອີ້ຍເຖິງທ່ານໃນເນື້ອຫາຫຼັກ',
          date: DateTime.now().subtract(const Duration(days: 1)),
          isRead: false,
        ),
        NotificationItem(
          id: '2',
          title: 'ແສງຈັນ ສອນງາມ',
          details: 'ໄດ້ຄອມເມນ: "ສົນໃຈ"',
          date: DateTime.now().subtract(const Duration(days: 2)),
          isRead: true,
        ),
        NotificationItem(
          id: '3',
          title: 'ທ່ານມີຄໍາຮ້ອງຂໍຮ່ວມມື',
          details: 'ຄໍາຮ້ອງຂໍຮ່ວມມືທີ່ໃຫ້ຕອບກັບ!',
          date: DateTime.now().subtract(const Duration(days: 3)),
          isRead: false,
        ),
        NotificationItem(
          id: '4',
          title: 'ບຸນມີ ອຸໄລພອນ',
          details: 'ສະແດງຄວາມສົນໃຈໃນໂພສຂອງທ່ານ',
          date: DateTime.now().subtract(const Duration(days: 4)),
          isRead: true,
        ),
        NotificationItem(
          id: '5',
          title: 'ແກ້ວມະນີ ສີສຸກ',
          details: 'ໄດ້ຕິດຕາມທ່ານ',
          date: DateTime.now().subtract(const Duration(days: 5)),
          isRead: false,
        ),
      ];
    });
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index].isRead = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  List<NotificationItem> get _filteredNotifications {
    return _notifications.where((notification) {
      return _selectedTab == NotificationTabs.unread
          ? !notification.isRead
          : notification.isRead;
    }).toList();
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return S
          .of(context)
          .daysAgo(difference.inDays.toString()); // ต้องเพิ่มใน l10n
    } else if (difference.inHours > 0) {
      return S
          .of(context)
          .hoursAgo(difference.inHours.toString()); // ต้องเพิ่มใน l10n
    } else if (difference.inMinutes > 0) {
      return S.of(context).minutesAgo(difference.inMinutes.toString());
    } else {
      return S.of(context).justNow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).notifications,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (_selectedTab == NotificationTabs.unread &&
              _filteredNotifications.isNotEmpty)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                S.of(context).markAllAsRead,
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Segmented Control
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(NotificationTabs.unread, 0),
                    ),
                    Expanded(child: _buildTabButton(NotificationTabs.read, 1)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                color: _primaryColor,
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  _loadNotifications();
                },
                child: _filteredNotifications.isEmpty
                    ? Center(
                        child: Text(
                          _selectedTab == NotificationTabs.unread
                              ? S.of(context).noUnreadNotifications
                              : S.of(context).noReadNotifications,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                    : ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: _filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final notification = _filteredNotifications[index];
                          return _buildNotificationItem(notification);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String tab, int index) {
    bool isSelected = _selectedTab == tab;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tab;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Text(
            _getTabDisplayText(tab), // ใช้ function แปลงเป็นข้อความ
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (!notification.isRead) {
            _markAsRead(notification.id);
          }

          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NotificationDetailPage(
                notification: notification,
                onMarkAsRead: () => _markAsRead(notification.id),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: !notification.isRead
                ? Border.all(color: _primaryColor.withOpacity(0.3), width: 1.5)
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
                      color: _primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: _primaryColor,
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
                          color: _primaryColor,
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
                          _formatTimeAgo(notification.date),
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

class NotificationDetailPage extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onMarkAsRead;

  const NotificationDetailPage({
    super.key,
    required this.notification,
    required this.onMarkAsRead,
  });

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          S.of(context).notificationDetail,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.color1.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.color1,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatDate(notification.date),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.color1,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              S.of(context).newNotification,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Content Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).details,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        notification.details,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
