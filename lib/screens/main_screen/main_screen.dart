import 'package:flutter/material.dart';
import 'package:homefind/auth/login_check/auth_check.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/home_page/home_page.dart';
import 'package:homefind/screens/add/add_page.dart';
import 'package:homefind/screens/join/join_page/join_page.dart';
import 'package:homefind/screens/notification/notification_page.dart';
import 'package:homefind/screens/profile/profile_pages/profile_page.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List<Widget> get _pages => [
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

  Future<void> _checkTermsAndRedirectIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    bool termsAccepted = prefs.getBool('terms_accepted') ?? false;

    if (!termsAccepted) {
      _changePage(1);
    } else {
      _changePage(2);
    }
  }

  Future<void> _handlePageChange(int index) async {
    if (index == 0) {
      _changePage(index);
      return;
    }

    bool isLoggedIn = await AuthChecker.isLoggedIn();

    if (!isLoggedIn) {
      Widget targetPage = _pages[index];
      await AuthChecker.checkAuthAndNavigate(
        context: context,
        showLoginPrompt: true,
        page: targetPage,
      );

      if (await AuthChecker.isLoggedIn()) {
        if (index == 2) {
          await _checkTermsAndRedirectIfNeeded();
        } else {
          _changePage(index);
        }
      }
      return;
    }

    if (index == 2) {
      await _checkTermsAndRedirectIfNeeded();
    } else {
      _changePage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
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
          selectedItemColor: AppColors.color1,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: S.of(context).homepage,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.join_full, size: 30),
              label: S.of(context).joinpage,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _currentIndex == 2 ? AppColors.color1 : null,
                  gradient: _currentIndex == 2
                      ? null
                      : LinearGradient(
                          colors: [AppColors.color1, AppColors.color2],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 27),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 30),
              label: S.of(context).notification,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: S.of(context).profile,
            ),
          ],
        ),
      ),
    );
  }
}
