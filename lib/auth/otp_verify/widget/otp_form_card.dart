import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class OTPFormCard extends StatelessWidget {
  final String phoneNumber;
  final TextEditingController otpController;
  final String? errorText;
  final bool isLoading;
  final int resendCountdown;
  final VoidCallback onVerifyOtp;
  final VoidCallback onResendOtp;

  const OTPFormCard({
    super.key,
    required this.phoneNumber,
    required this.otpController,
    required this.errorText,
    required this.isLoading,
    required this.resendCountdown,
    required this.onVerifyOtp,
    required this.onResendOtp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    text: S.of(context).send_otp_to,
                    style: TextStyle(
                      fontFamily: 'NotoSansLao',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: phoneNumber,
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
              controller: otpController,
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
                errorText: errorText,
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
                onPressed: isLoading ? null : onVerifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF008B8B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      )
                    : Text(
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
              onPressed: resendCountdown > 0 ? null : onResendOtp,
              child: Text(
                resendCountdown > 0
                    ? '${S.of(context).resend_otp} ($resendCountdown ${S.of(context).seconds})'
                    : S.of(context).resend_otp,
                style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  color: resendCountdown > 0
                      ? Colors.grey
                      : const Color(0xFF008B8B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}