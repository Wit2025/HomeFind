import 'package:flutter/material.dart';
import 'package:homefind/service/Auth_Service.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/main_screen.dart';
import 'package:homefind/auth/forget_pass.dart';
import 'package:homefind/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// import 'dart:math';

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

  // String _generateOtp() {
  //   final random = Random();
  //   return (100000 + random.nextInt(900000)).toString();
  // }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.loginWithPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
      );

      if (response.statusCode == 201) {
        // สมมติว่า response body เป็น JSON ที่มี token หรือข้อมูลผู้ใช้
        final data = jsonDecode(response.body);
        final token = data['token'] ?? ''; // กรณี backend ส่ง token

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
        // ล็อกอินไม่สำเร็จ แจ้ง error
        final errorMsg =
            // 'Login failed. Please check your phone number and password.'
            S.of(context).login_failed;
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMsg)));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              // 'An error occurred: $e')));
              '${S.of(context).error_occurred}: $e',
            ),
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
                // Header with gradient
                Container(
                  height: isSmallScreen
                      ? size.height * 0.3
                      : size.height * 0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00CEB0), Color(0xFF006B8B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: isSmallScreen ? 70 : 90,
                            height: isSmallScreen ? 70 : 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            // 'ຍິນດີຕ້ອນຮັບສູ່ Home Find'
                            S.of(context).welcome_home_find,
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: isSmallScreen ? 20 : 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            // 'ກະລຸນາເຂົ້າສູ່ລະບົບ'
                            S.of(context).please_login,
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: isSmallScreen ? 14 : 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Login form container
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 16 : 24,
                    ),
                    padding: EdgeInsets.all(isSmallScreen ? 20 : 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              // 'ເຂົ້າສູ່ລະບົບ',
                              S.of(context).login,
                              style: TextStyle(
                                fontFamily: 'NotoSansLao',
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF008B8B),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Phone number field
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              // labelText: 'ເບີໂທ',
                              labelText: S.of(context).phone,
                              labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                            ),
                            style: TextStyle(fontFamily: 'NotoSansLao'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                // return 'ກະລຸນາໃສ່ເບີໂທ';
                                return S.of(context).please_enter_phone;
                              }
                              if (!RegExp(r'^[0-9]{8,15}$').hasMatch(value)) {
                                // return 'ເບີໂທບໍ່ຖືກຕ້ອງ';
                                return S.of(context).invalid_phone_number;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Password field (hidden in this flow but kept for future use)
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              // labelText: 'ລະຫັດຜ່ານ',
                              labelText: S.of(context).password,
                              labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  );
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                            ),
                            style: TextStyle(fontFamily: 'NotoSansLao'),
                            obscureText: _obscurePassword,
                            validator: (value) =>
                                null, // No validation for password in OTP flow
                          ),
                          const SizedBox(height: 8),

                          // Remember me and Forgot password row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Remember me checkbox
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    activeColor: const Color(0xFF008B8B),
                                  ),
                                  Text(
                                    // 'ຈື່ຈຳຜູ້ໃຊ້ງານ'
                                    S.of(context).remember_user,
                                    style: TextStyle(
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),

                              // Forgot password
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPassPage(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  // 'ລືມລະຫັດຜ່ານ?'
                                  S.of(context).forgot_password,
                                  style: TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    color: const Color(0xFF008B8B),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Login button (will navigate to OTP page)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF008B8B),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      // 'ເຂົ້າສູ່ລະບົບ'
                                      S.of(context).login,
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao',
                                        fontSize: isSmallScreen ? 16 : 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Divider with "OR"
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  // 'ຫຼື'
                                  S.of(context).or,
                                  style: TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Google Sign-In Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: _isLoading ? null : _signInWithGoogle,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    // 'ເຂົ້າສູ່ລະບົບດ້ວຍ Google'
                                    S.of(context).login_with_google,
                                    style: TextStyle(
                                      fontFamily: 'NotoSansLao',
                                      fontSize: isSmallScreen ? 14 : 16,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Sign up link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // 'ຍັງບໍ່ມີບັນຊີ?'
                                S.of(context).no_account_yet,
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao',
                                  fontSize: isSmallScreen ? 14 : 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  // 'ລົງທະບຽນ'
                                  S.of(context).register,
                                  style: TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: const Color(0xFF008B8B),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
