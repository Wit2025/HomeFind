import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homefind/auth/login/login.dart';
import 'package:homefind/auth/otp_verify/otp_verify_page.dart';
import 'package:homefind/auth/register/widget/register_form.dart';
import 'package:homefind/auth/register/widget/register_header.dart';
import 'package:homefind/screens/main_screen.dart';
import 'dart:math';
import 'package:homefind/service/Auth_Service.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final bool _rememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _generateRandomOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).accept_terms_first)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.registerWithPhoneNumber(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final testOtp = _generateRandomOtp();

        if (mounted) {
          setState(() => _isLoading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerifyPage(
                generatedOtp: testOtp,
                phoneNumber: _phoneController.text,
                rememberMe: _rememberMe,
              ),
            ),
          );
        }
      } else {
        final errorData = jsonDecode(response.body);
        String errorMessage =
            errorData['message'] ?? S.of(context).registration_error;

        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.teal),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context).error_occurred}: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
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

  void _toggleAcceptTerms(bool? value) {
    setState(() => _acceptTerms = value ?? false);
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RegisterHeader(isSmallScreen: isSmallScreen),
            const SizedBox(height: 4),
            Transform.translate(
              offset: const Offset(0, -30),
              child: RegisterForm(
                formKey: _formKey,
                usernameController: _usernameController,
                emailController: _emailController,
                phoneController: _phoneController,
                passwordController: _passwordController,
                isSmallScreen: isSmallScreen,
                isLoading: _isLoading,
                obscurePassword: _obscurePassword,
                acceptTerms: _acceptTerms,
                onSubmitForm: _submitForm,
                onSignInWithGoogle: _signInWithGoogle,
                onTogglePasswordVisibility: _togglePasswordVisibility,
                onToggleAcceptTerms: _toggleAcceptTerms,
                onNavigateToLogin: _navigateToLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}