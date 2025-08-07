import 'package:flutter/material.dart';
import 'package:homefind/auth/auth_check.dart';
import 'package:homefind/screens/home/home_page.dart';
import 'package:homefind/screens/add/add_page.dart';
import 'package:homefind/screens/join/join_page.dart';
import 'package:homefind/screens/notification/notification_page.dart';
import 'package:homefind/screens/profile/profile_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(),
      JoinPages(
        onGoToAddPage: () {
          setState(() {
            _currentIndex = 2;
          });
        },
      ),
      AddPage(),
      NotificationsBody(),
      ProfilePage(),
    ];
  }

  Future<void> _handlePageChange(int index) async {
    if (index == 0) {
      _changePage(index);
      return;
    }

    // Check auth status first
    bool isLoggedIn = await AuthChecker.isLoggedIn();

    if (isLoggedIn) {
      // User is logged in, just change the page
      _changePage(index);
    } else {
      // User not logged in, show auth flow
      Widget targetPage = _pages[index];
      await AuthChecker.checkAuthAndNavigate(
        context: context,
        showLoginPrompt: true,
        page: targetPage,
      );

      // Check again after auth flow
      if (await AuthChecker.isLoggedIn()) {
        _changePage(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _handlePageChange,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'ໜ້າຫຼັກ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.join_full, size: 30),
              label: 'ເຂົ້າຮ່ວມ',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 27),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 30),
              label: 'ແຈ້ງເຕືອນ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: 'ໂປຟາຍ',
            ),
          ],
        ),
      ),
    );
  }
}
