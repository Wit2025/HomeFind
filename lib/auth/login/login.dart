import 'package:flutter/material.dart';
import 'package:homefind/auth/login/widget/login_form.dart';
import 'package:homefind/auth/login/widget/login_header.dart';
import 'package:homefind/service/service_auth.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/main_screen/main_screen.dart';
import 'package:homefind/auth/forget_password/forget_pass.dart';
import 'package:homefind/auth/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('rememberMe') ?? false;

    if (rememberMe) {
      setState(() {
        _rememberMe = true;
        _phoneController.text = prefs.getString('savedPhone') ?? '';
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.loginWithPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['token'] ?? '';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        await prefs.setBool('isLoggedIn', true);

        if (_rememberMe) {
          await prefs.setBool('rememberMe', true);
          await prefs.setString('savedPhone', _phoneController.text.trim());
        } else {
          await prefs.setBool('rememberMe', false);
          await prefs.remove('savedPhone');
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        final errorMsg = S.of(context).login_failed;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMsg)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context).error_occurred}: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _toggleRememberMe(bool? value) {
    setState(() => _rememberMe = value ?? false);
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgetPassPage()),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: Column(
              children: [
                LoginHeader(isSmallScreen: isSmallScreen),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: LoginForm(
                    formKey: _formKey,
                    phoneController: _phoneController,
                    passwordController: _passwordController,
                    isLoading: _isLoading,
                    obscurePassword: _obscurePassword,
                    rememberMe: _rememberMe,
                    isSmallScreen: isSmallScreen,
                    onSubmitForm: _submitForm,
                    onSignInWithGoogle: _signInWithGoogle,
                    onTogglePasswordVisibility: _togglePasswordVisibility,
                    onToggleRememberMe: _toggleRememberMe,
                    onNavigateToForgotPassword: _navigateToForgotPassword,
                    onNavigateToRegister: _navigateToRegister,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}