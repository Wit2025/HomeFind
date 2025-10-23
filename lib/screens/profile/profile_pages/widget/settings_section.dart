import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/change_password/change_password.dart';
import 'package:homefind/screens/profile/pages/help/help.dart';
import 'package:homefind/screens/profile/pages/history_booking/history_booking.dart';
import 'package:homefind/screens/profile/pages/languege/languege.dart';
import 'package:homefind/screens/profile/pages/my_account/my_account.dart';
import 'package:homefind/screens/profile/pages/privacy/privacy.dart';
import 'package:homefind/widgets/colors.dart';

class SettingsSection extends StatelessWidget {
  final VoidCallback onLogout;

  const SettingsSection({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).general,
          style: const TextStyle(
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
              MaterialPageRoute(builder: (context) => MyAccountPage()),
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
              MaterialPageRoute(builder: (context) => ChangePasswordPages()),
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
              MaterialPageRoute(builder: (context) => LanguagePage()),
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
              MaterialPageRoute(builder: (context) => HistoryBookingPages()),
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
              MaterialPageRoute(builder: (context) => PrivacyPages()),
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
              MaterialPageRoute(builder: (context) => HelpPages()),
            );
          },
        ),
        _buildSettingsItem(
          context: context,
          title: S.of(context).logout,
          icon: Icons.logout,
          iconColor: Colors.red,
          textColor: Colors.red,
          onTap: onLogout,
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required BuildContext context,
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
