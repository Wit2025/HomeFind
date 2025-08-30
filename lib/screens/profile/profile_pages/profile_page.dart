import 'package:flutter/material.dart';
import 'package:homefind/screens/profile/profile_pages/widget/income_expense_card.dart';
import 'package:homefind/screens/profile/profile_pages/widget/logout_dialog.dart';
import 'package:homefind/screens/profile/profile_pages/widget/profile_header.dart';
import 'package:homefind/screens/profile/profile_pages/widget/settings_section.dart';
import 'package:homefind/widgets/Colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout(BuildContext context) async {
    await LogoutDialog.show(context);
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

                          // Income/Expense Card
                          const IncomeExpenseCard(),

                          const SizedBox(height: 30),

                          // Settings Section
                          SettingsSection(onLogout: () => logout(context)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Profile Header
              const ProfileHeader(),
            ],
          ),
        ),
      ),
    );
  }
}
