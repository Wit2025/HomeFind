import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/main_screen.dart';
import 'package:homefind/widgets/Colors.dart' show AppColors;
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerifyPage extends StatefulWidget {
  final String generatedOtp;
  final String phoneNumber;
  final bool rememberMe;

  const OTPVerifyPage({
    super.key,
    required this.generatedOtp,
    required this.phoneNumber,
    required this.rememberMe,
  });

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  final _otpController = TextEditingController();
  String? _errorText;
  bool _isLoading = false;
  int _resendCountdown = 60;
  late Timer _timer;
  String? _currentOtp; // Store the current OTP

  @override
  void initState() {
    super.initState();
    _currentOtp = widget.generatedOtp;
    _startCountdown();
    // For testing - shows OTP in console and as a snackbar
    _showTestOtp(context);
  }

  void _showTestOtp(BuildContext context) {
    // Show as a floating notification at the top of the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.sms, color: Colors.blue, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          // 'SMS Message',
                          S.of(context).sms_message,
                          style: TextStyle(
                            fontFamily: 'NotoSansLao',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          // 'Now',
                          S.of(context).now,
                          style: TextStyle(
                            fontFamily: 'NotoSansLao',
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      // 'ລະຫັດຢືນຢັນຂອງທ່ານ: $_currentOtp',
                      '${S.of(context).your_verification_code}: $_currentOtp',
                      style: TextStyle(
                        fontFamily: 'NotoSansLao',
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      // 'ຫ້າມໃຫ້ບອກລະຫັດນີ້ໃຫ້ຜູ້ອື່ນ',
                      S.of(context).do_not_share_code,
                      style: TextStyle(
                        fontFamily: 'NotoSansLao',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        _timer.cancel();
      }
    });
  }

  String _generateNewOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Also update the _resendOtp method to show the same style notification:
  void _resendOtp(BuildContext context) {
    final newOtp = _generateNewOtp();
    setState(() {
      _resendCountdown = 60;
      _errorText = null;
      _currentOtp = newOtp;
      _startCountdown();
    });

    // Show the new OTP in the same notification style
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.sms, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        // 'SMS Message',
                        // 'SMS Message',
                        S.of(context).sms_message,
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        // 'Now',
                        S.of(context).now,
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // 'ລະຫັດຢືນຢັນໃຫມ່ຂອງທ່ານ: $newOtp',
                    '${S.of(context).your_new_verification_code}: $newOtp',
                    style: TextStyle(
                      fontFamily: 'NotoSansLao',
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // 'ລະຫັດນີ້ຈະໝົດອາຍຸໃນ 5 ນາທີ',
                    S.of(context).code_expires_5_minutes,
                    style: TextStyle(
                      fontFamily: 'NotoSansLao',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verifyOtp() async {
    final enteredOtp = _otpController.text;
    if (enteredOtp.isEmpty || enteredOtp.length != 6) {
      // setState(() => _errorText = 'ກະລຸນາປ້ອນ OTP 6 ຕົວເລກ');
      setState(() => _errorText = S.of(context).enter_6_digit_otp);
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () async {
      setState(() => _isLoading = false);

      if (enteredOtp == _currentOtp) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        if (widget.rememberMe) {
          await prefs.setString('savedPhone', widget.phoneNumber);
          await prefs.setBool('rememberMe', true);
        } else {
          // Clear saved credentials if rememberMe is false
          await prefs.remove('savedPhone');
          await prefs.remove('savedPassword');
          await prefs.setBool('rememberMe', false);
        }
        // Show beautiful success dialog
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel: '',
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) {
            return ScaleTransition(
              scale: CurvedAnimation(parent: __, curve: Curves.easeOutBack),
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(20),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Background container
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.color1, AppColors.color2],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            // 'ສຳເລັດ!',
                            '${S.of(context).completed}!',
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF008B8B),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            // 'ທ່ານໄດ້ຢືນຢັນ OTP ສຳເລັດ',
                            S.of(context).otp_verified_successfully,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: 220,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                // 'ໄປທີ່ໜ້າຫຼັກ',
                                S.of(context).go_to_homepage,
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Animated checkmark icon
                    Positioned(
                      top: -40,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00CEB0),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00CEB0).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        HapticFeedback.lightImpact();
        // setState(() => _errorText = '❌ OTP ບໍ່ຖືກຕ້ອງ, ກະລຸນາລອງໃໝ່');
        setState(
          () => _errorText = '❌ ${S.of(context).otp_incorrect_try_again}',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      body: Column(
        children: [
          // Header Section
          Container(
            height: isSmallScreen ? size.height * 0.25 : size.height * 0.3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.color1, AppColors.color2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.verified_user,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        // 'ຢືນຢັນ OTP',
                        S.of(context).verify_otp,
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: isSmallScreen ? 28 : 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        // 'ກະລຸນາປ້ອນລະຫັດຢືນຢັນ',
                        S.of(context).please_enter_verification_code,
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: isSmallScreen ? 16 : 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // OTP Form
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: isSmallScreen ? 20 : 30,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  // text: 'ສົ່ງລະຫັດ OTP ໄປຫາ ',
                                  text: S.of(context).send_otp_to,
                                  style: TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.phoneNumber,
                                  style: const TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF008B8B),
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),

                          TextField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 24,
                              letterSpacing: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: '••••••',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                letterSpacing: 8,
                              ),
                              errorText: _errorText,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              counterText: '',
                            ),
                          ),
                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _verifyOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF008B8B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      // 'ຢືນຢັນ',
                                      S.of(context).confirm,
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao',
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextButton(
                            onPressed: _resendCountdown > 0
                                ? null
                                : () => _resendOtp(context),
                            child: Text(
                              _resendCountdown > 0
                                  // ? 'ສົ່ງ OTP ອີກຄັ້ງ ($_resendCountdown ວິນາທີ)'
                                  // : 'ສົ່ງ OTP ອີກຄັ້ງ',
                                  ? '${S.of(context).resend_otp} ($_resendCountdown ${S.of(context).seconds})'
                                  : S.of(context).resend_otp,
                              style: TextStyle(
                                fontFamily: 'NotoSansLao',
                                color: _resendCountdown > 0
                                    ? Colors.grey
                                    : const Color(0xFF008B8B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
