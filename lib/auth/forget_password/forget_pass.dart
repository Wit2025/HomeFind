import 'package:flutter/material.dart';
import 'package:homefind/auth/forget_password/widget/otp_verification_page.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendResetCode() {
    final phone = _phoneController.text;
    if (phone.isEmpty || !RegExp(r'^[0-9]{8,15}$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // content: Text('ເບີໂທບໍ່ຖືກຕ້ອງ'),
          content: Text(S.of(context).invalid_phone_number),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to OTP verification page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationPage(phoneNumber: phone),
      ),
    );
  }

  // ໜ້າປ້ອນເບີໂທ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          // 'ລືມລະຫັດຜ່ານ',
          S.of(context).forgot_password,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                // 'ປ້ອນເບີໂທລະສັບຂອງທ່ານ',
                S.of(context).please_enter_phone,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                // 'ເພື່ອຮັບລະຫັດ OTP ໃນການປ່ຽນລະຫັດຜ່ານ',
                S.of(context).otp_for_password_change,
                style: TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  // labelText: 'ເບີໂທລະສັບ',
                  labelText: S.of(context).phone,
                  labelStyle: const TextStyle(color: AppColors.color1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.color1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.color1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.color1,
                      width: 2,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.phone, color: AppColors.color1),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.color1, AppColors.color2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _sendResetCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    S.of(context).send_otp_code,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  // 'ກັບຄືນໜ້າລ໋ອກອິນ',
                  S.of(context).back_to_login,
                  style: TextStyle(
                    color: AppColors.color1,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}