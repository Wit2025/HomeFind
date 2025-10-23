import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart' show AppColors;

class OTPHeader extends StatelessWidget {
  final bool isSmallScreen;

  const OTPHeader({super.key, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
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
                const Icon(Icons.verified_user, size: 50, color: Colors.white),
                const SizedBox(height: 16),
                Text(
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
                  S.of(context).please_enter_verification_code,
                  style: TextStyle(
                    fontFamily: 'NotoSansLao',
                    fontSize: isSmallScreen ? 16 : 18,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
