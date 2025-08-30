import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homefind/auth/otp_verify/widget/otp_form_card.dart';
import 'package:homefind/auth/otp_verify/widget/otp_header.dart';
import 'package:homefind/auth/otp_verify/widget/otp_notification.dart';
import 'package:homefind/auth/otp_verify/widget/otp_success_dialog.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/main_screen.dart';
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
      OTPNotification.show(
        context: context,
        otp: _currentOtp!,
        isNewCode: false,
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

  void _resendOtp(BuildContext context) {
    final newOtp = _generateNewOtp();
    setState(() {
      _resendCountdown = 60;
      _errorText = null;
      _currentOtp = newOtp;
      _startCountdown();
    });

    // Show the new OTP in the same notification style
    OTPNotification.show(context: context, otp: newOtp, isNewCode: true);
  }

  void _verifyOtp() async {
    final enteredOtp = _otpController.text;
    if (enteredOtp.isEmpty || enteredOtp.length != 6) {
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
        OTPSuccessDialog.show(
          context: context,
          onGoToHomepage: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
            );
          },
        );
      } else {
        HapticFeedback.lightImpact();
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
          OTPHeader(isSmallScreen: isSmallScreen),

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
                  OTPFormCard(
                    phoneNumber: widget.phoneNumber,
                    otpController: _otpController,
                    errorText: _errorText,
                    isLoading: _isLoading,
                    resendCountdown: _resendCountdown,
                    onVerifyOtp: _verifyOtp,
                    onResendOtp: () => _resendOtp(context),
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
