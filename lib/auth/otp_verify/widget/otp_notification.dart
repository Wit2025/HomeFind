import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class OTPNotification {
  static void show({
    required BuildContext context,
    required String otp,
    required bool isNewCode,
  }) {
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
                        S.of(context).sms_message,
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const Spacer(),
                      Text(
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
                    isNewCode
                        ? '${S.of(context).your_new_verification_code}: $otp'
                        : '${S.of(context).your_verification_code}: $otp',
                    style: TextStyle(
                      fontFamily: 'NotoSansLao',
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isNewCode
                        ? S.of(context).code_expires_5_minutes
                        : S.of(context).do_not_share_code,
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
}