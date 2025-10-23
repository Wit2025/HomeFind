import 'package:flutter/material.dart';
import 'package:homefind/auth/login_check/auth_check.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/home_page/home_page.dart';
import 'package:homefind/screens/add/add_page.dart';
import 'package:homefind/screens/join/join_page/join_page.dart';
import 'package:homefind/screens/notification/notification_page.dart';
import 'package:homefind/screens/profile/profile_pages/profile_page.dart';
import 'package:homefind/screens/service/service_page.dart';
import 'package:homefind/widgets/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  late ScrollController _homeScrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);

    _homeScrollController = ScrollController();
  }

  void _handleTabChange() {
    setState(() {
      // อัพเดท UI เมื่อแท็บเปลี่ยน (เพื่อซ่อน/แสดง BottomNavigationBar)
    });
  }

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // หน้าเนื้อหาตามแท็บด้านล่าง (BottomNavigationBar)
  List<Widget> get _pages => [
    _buildHomeContent(),
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

  // Widget เนื้อหาหลักที่รวม TabBar และเนื้อหาตามแท็บ
  Widget _buildHomeContent() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Fixed header with tabs - ไม่เลื่อนตาม scroll
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.color1, AppColors.color2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 2),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    // Header with app title
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),

                    // Modern TabBar - Fixed position
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.color1, width: 1),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [AppColors.color1, AppColors.color2],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.color1.withValues(alpha: 0.3),
                              offset: Offset(0, 2),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.color1,
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        dividerColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        tabs: [
                          SizedBox(
                            height: 44,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.home_rounded, size: 20),
                                // SizedBox(width: 8),
                                Text('ທີ່ພັກ'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 44,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.build_rounded, size: 20),
                                // SizedBox(width: 8),
                                Text('ບໍລິການ'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomePage(scrollController: _homeScrollController),
                ServiceRequestPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
        // ignore: use_build_context_synchronously
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
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _homeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldHideBottomNav = _currentIndex == 0 && _tabController.index == 1;

    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      body: _pages[_currentIndex],
      bottomNavigationBar: shouldHideBottomNav
          ? null
          : _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            spreadRadius: 0,
            blurRadius: 20,
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
        unselectedItemColor: Color(0xFF718096),
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.home_rounded, size: 26),
            ),
            label: S.of(context).homepage,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.join_full_rounded, size: 26),
            ),
            label: S.of(context).joinpage,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.color1, AppColors.color2],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.color1.withValues(alpha: 0.3),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(Icons.add_rounded, color: Colors.white, size: 24),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.notifications_rounded, size: 26),
            ),
            label: S.of(context).notification,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.person_rounded, size: 26),
            ),
            label: S.of(context).profile,
          ),
        ],
      ),
    );
  }
}
