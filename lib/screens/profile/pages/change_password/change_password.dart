import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/change_password/widget/change_password_form.dart';
import 'package:homefind/screens/profile/pages/change_password/widget/gradient_appbar.dart';

class ChangePasswordPages extends StatefulWidget {
  const ChangePasswordPages({super.key});

  @override
  State<ChangePasswordPages> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // เพิ่ม key เพื่อบังคับ rebuild เมื่อภาษาเปลี่ยน
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      appBar: GradientAppBar(
        title: S.of(context).changePassword,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ChangePasswordForm(
                  onChangePassword: _handleChangePassword,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleChangePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).changePassword),
        backgroundColor: Colors.green,
      ),
    );
  }
}
