import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/main_screen.dart';
import 'package:homefind/screens/profile/pages/help.dart';
import 'package:homefind/screens/profile/pages/change_password.dart';
import 'package:homefind/screens/profile/pages/history_booking.dart';
import 'package:homefind/screens/profile/pages/languege.dart';
import 'package:homefind/screens/profile/pages/my_account.dart';
import 'package:homefind/screens/profile/pages/privacy.dart';
import 'package:homefind/screens/profile/pages/history_transaction.dart';
import 'package:homefind/screens/profile/pages/point.dart';
import 'package:homefind/screens/profile/pages/withdraw.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.color1, AppColors.color2],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated icon
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.25).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticOut,
                      ),
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title with fade animation
                  FadeTransition(
                    opacity: animation,
                    child: Text(
                      S.of(context).logout,
                      style: TextStyle(
                        fontFamily: 'NotoSansLao',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Message with slide animation
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Text(
                      S.of(context).logoutConfirm,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NotoSansLao',
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Buttons row with staggered animation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Cancel button
                      ScaleTransition(
                        scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(
                              0.4,
                              1.0,
                              curve: Curves.easeOutBack,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            S.of(context).cancel,
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              color: AppColors.color1,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // Confirm button with updated logic
                      ScaleTransition(
                        scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: const Interval(
                              0.6,
                              1.0,
                              curve: Curves.easeOutBack,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();

                            // Check if "Remember Me" was enabled
                            final rememberMe =
                                prefs.getBool('rememberMe') ?? false;

                            // Always clear login status
                            await prefs.setBool('isLoggedIn', false);

                            await prefs.remove('savedPassword');

                            // Only clear credentials if "Remember Me" wasn't checked
                            if (!rememberMe) {
                              await prefs.remove('savedPhone');
                              await prefs.remove('savedPassword');
                            }

                            // Haptic feedback
                            HapticFeedback.mediumImpact();

                            // Close the dialog
                            // Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            S.of(context).logout,
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.color1, AppColors.color2],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 140),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 150),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildIncomeExpenseItem(
                                      context, // ต้องส่ง context
                                      Icons.arrow_upward,
                                      S.of(context).income, // เอาคำแปลมาเลย
                                      '₭ 3,214',
                                      Colors.green,
                                    ),

                                    const SizedBox(width: 10),
                                    Container(
                                      width: 5,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _buildFeeItem(
                                      context,
                                      Icons.arrow_downward,
                                      S.of(context).fee,
                                      '₭ 1,550',
                                      Colors.red,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildActionButton(
                                        context: context,
                                        icon: Icons.download,
                                        label: S.of(context).withdraw,
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: AppColors.color1,
                                        labelColor: Colors.black,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WithdrawPages(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildActionButton(
                                        context: context,
                                        icon: Icons.emoji_events,
                                        label: S.of(context).points,
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: AppColors.color1,
                                        labelColor: Colors.black,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PointPages(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildActionButton(
                                        context: context,
                                        icon: Icons.history,
                                        label: S.of(context).withdrawHistory,
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: AppColors.color1,
                                        labelColor: Colors.black,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryTransaction(),
                                            ),
                                          );
                                        },
                                      ),
                                      _buildActionButton(
                                        context: context,
                                        icon: Icons.mobile_screen_share,
                                        label: S.of(context).inviteFriends,
                                        backgroundColor: const Color.fromARGB(
                                          61,
                                          158,
                                          158,
                                          158,
                                        ),
                                        iconColor: AppColors.color1,
                                        labelColor: Colors.black,
                                        onTap: () {
                                          // Add invite friends functionality
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          Text(
                            S.of(context).general,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildSettingsItem(
                            context: context,
                            title: S.of(context).personalInfo,
                            icon: Icons.person,
                            iconColor: AppColors.color1,
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyAccountPage(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            context: context,
                            title: S.of(context).changePassword,
                            icon: Icons.lock,
                            iconColor: AppColors.color1,
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            context: context,
                            title: S.of(context).language,
                            icon: Icons.language,
                            iconColor: AppColors.color1,
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LanguegePage(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            context: context,
                            title: S.of(context).bookingHistory,
                            icon: Icons.history,
                            iconColor: AppColors.color1,
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryBookingPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            context: context,
                            title: S.of(context).termsPolicies,
                            icon: Icons.receipt,
                            iconColor: AppColors.color1,
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            context: context,
                            title: S.of(context).help,
                            icon: Icons.help,
                            iconColor: AppColors.color1,
                            textColor: Colors.black87,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HelpPages(),
                                ),
                              );
                            },
                          ),
                          _buildSettingsItem(
                            context: context,
                            title: S.of(context).logout,
                            icon: Icons.logout,
                            iconColor: Colors.red,
                            textColor: Colors.red,
                            onTap: () => logout(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 85,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/house.jpg'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Email.com',
                      style: TextStyle(color: Colors.black, fontSize: 14),
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

  Widget _buildIncomeExpenseItem(
    BuildContext context,
    IconData icon,
    String title,
    String amount,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeeItem(
    BuildContext context,
    IconData icon,
    String title,
    String amount,
    Color color,
  ) {
    // โครงสร้างเหมือนกัน หรือจะเปลี่ยนสไตล์ได้ตามต้องการ
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context, // เพิ่ม context
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color iconColor,
    required Color labelColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required BuildContext context, // เพิ่ม context
    required String title,
    required IconData icon,
    Color iconColor = Colors.grey,
    Color textColor = Colors.black,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          onTap: onTap ?? () {},
        ),
        Divider(color: Colors.grey[200], height: 1),
      ],
    );
  }
}
