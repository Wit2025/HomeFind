import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/notification/widget/notification_constant.dart';
import 'package:homefind/screens/notification/widget/notification_item.dart';
import 'package:homefind/screens/notification/widget/notification_item_widget.dart';
import 'package:homefind/screens/notification/widget/notification_tab_button.dart';
import 'package:homefind/widgets/Colors.dart';

class NotificationsBody extends StatefulWidget {
  const NotificationsBody({super.key});

  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  final _primaryColor = AppColors.color1;
  final _scrollController = ScrollController();

  String _selectedTab = NotificationTabs.unread;
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
                    NotificationTabButton(
                      tab: NotificationTabs.unread,
                      isSelected: _selectedTab == NotificationTabs.unread,
                      onTap: () => setState(
                        () => _selectedTab = NotificationTabs.unread,
                      ),
                    ),
                    NotificationTabButton(
                      tab: NotificationTabs.read,
                      isSelected: _selectedTab == NotificationTabs.read,
                      onTap: () =>
                          setState(() => _selectedTab = NotificationTabs.read),
                    ),
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
                          return NotificationItemWidget(
                            notification: notification,
                            onMarkAsRead: _markAsRead,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
