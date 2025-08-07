import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime date;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
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
  final _primaryColor = const Color.fromARGB(255, 87, 167, 177);
  // ignore: unused_field
  final _darkPrimaryColor = const Color.fromARGB(255, 12, 105, 122);
  final _scrollController = ScrollController();

  String _selectedTab = 'ຍັງບໍ່ອ່ານ'; // Default to unread notifications
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

  void _loadNotifications() {
    // Mock data - in a real app, this would come from an API
    setState(() {
      _notifications = [
        NotificationItem(
          id: '1',
          title: 'ທອງດີ ສີສະຫວັດ',
          subtitle: 'ໄດ້ເອີ້ຍເຖິງທ່ານໃນເນື້ອຫາຫຼັກ',
          date: DateTime.now().subtract(const Duration(days: 1)),
          isRead: false,
        ),
        NotificationItem(
          id: '2',
          title: 'ແສງຈັນ ສອນງາມ',
          subtitle: 'ໄດ້ຄອມເມນ: "ສົນໃຈ"',
          date: DateTime.now().subtract(const Duration(days: 2)),
          isRead: true,
        ),
        NotificationItem(
          id: '3',
          title: 'ທ່ານມີຄໍາຮ້ອງຂໍຮ່ວມມື',
          subtitle: 'ຄໍາຮ້ອງຂໍຮ່ວມມືທີ່ໃຫ້ຕອບກັບ!',
          date: DateTime.now().subtract(const Duration(days: 3)),
          isRead: false,
        ),
        NotificationItem(
          id: '4',
          title: 'ບຸນມີ ອຸໄລພອນ',
          subtitle: 'ສະແດງຄວາມສົນໃຈໃນໂພສຂອງທ່ານ',
          date: DateTime.now().subtract(const Duration(days: 4)),
          isRead: true,
        ),
        NotificationItem(
          id: '5',
          title: 'ແກ້ວມະນີ ສີສຸກ',
          subtitle: 'ໄດ້ຕິດຕາມທ່ານ',
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
      return _selectedTab == 'ຍັງບໍ່ອ່ານ'
          ? !notification.isRead
          : notification.isRead;
    }).toList();
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} ມື້ຜ່ານໄປ';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ຊົ່ວໂມງຜ່ານໄປ';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ນາທີຜ່ານໄປ';
    } else {
      return 'ບໍ່ດົນມານີ້';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'ການແຈ້ງເຕືອນ',
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
              colors: [
                Color.fromARGB(255, 87, 167, 177),
                Color.fromARGB(255, 12, 105, 122),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),

        actions: [
          if (_selectedTab == 'ຍັງບໍ່ອ່ານ' && _filteredNotifications.isNotEmpty)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'ອ່ານທັງໝົດ',
                style: TextStyle(color: Colors.white), // White text
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
                    Expanded(child: _buildTabButton('ຍັງບໍ່ອ່ານ', 0)),
                    Expanded(child: _buildTabButton('ອ່ານແລ້ວ', 1)),
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
                          _selectedTab == 'ຍັງບໍ່ອ່ານ'
                              ? 'ບໍ່ມີການແຈ້ງເຕືອນທີ່ຍັງບໍ່ອ່ານ'
                              : 'ບໍ່ມີການແຈ້ງເຕືອນທີ່ອ່ານແລ້ວ',
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

  Widget _buildTabButton(String tabName, int index) {
    bool isSelected = _selectedTab == tabName;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tabName;
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
            tabName,
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
        onTap: () {
          if (!notification.isRead) {
            _markAsRead(notification.id);
          }
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
                        Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: !notification.isRead
                                ? FontWeight.bold
                                : FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
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
                      notification.subtitle,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: !notification.isRead
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
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
