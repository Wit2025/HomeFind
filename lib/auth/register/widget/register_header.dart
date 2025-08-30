import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

class RegisterHeader extends StatelessWidget {
  final bool isSmallScreen;

  const RegisterHeader({
    super.key,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: isSmallScreen ? size.height * 0.25 : size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.color1, AppColors.color2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Container
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
              const SizedBox(height: 10),
              // Title Text
              Text(
                S.of(context).create_new_account,
                style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  fontSize: isSmallScreen ? 24 : 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              // Subtitle Text
              Text(
                S.of(context).please_enter_your_info,
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
    );
  }
}