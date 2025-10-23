import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/change_password/widget/custorm_password_field.dart';
import 'gradient_button.dart';

class ChangePasswordForm extends StatefulWidget {
  final Function(String oldPassword, String newPassword, String confirmPassword)
  onChangePassword;

  const ChangePasswordForm({super.key, required this.onChangePassword});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).pleaseEnterNewPassword,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          CustomPasswordField(
            controller: _oldPasswordController,
            label: S.of(context).oldPassword,
            isVisible: _showOldPassword,
            onToggleVisibility: () {
              setState(() {
                _showOldPassword = !_showOldPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).pleaseEnterOldPassword;
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          CustomPasswordField(
            controller: _newPasswordController,
            label: S.of(context).newPassword,
            isVisible: _showNewPassword,
            onToggleVisibility: () {
              setState(() {
                _showNewPassword = !_showNewPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).pleaseEnterNewPasswordAgain;
              }
              if (value.length < 6) {
                return S.of(context).passwordMin6Chars;
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          CustomPasswordField(
            controller: _confirmPasswordController,
            label: S.of(context).confirmNewPassword,
            isVisible: _showConfirmPassword,
            onToggleVisibility: () {
              setState(() {
                _showConfirmPassword = !_showConfirmPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).pleaseConfirmNewPassword;
              }
              if (value != _newPasswordController.text) {
                return 'รหัสผ่านไม่ตรงกัน'; // Add this to your localization
              }
              return null;
            },
          ),

          const SizedBox(height: 30),

          GradientButton(
            text: S.of(context).changePassword,
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onChangePassword(
        _oldPasswordController.text,
        _newPasswordController.text,
        _confirmPasswordController.text,
      );
    }
  }
}
