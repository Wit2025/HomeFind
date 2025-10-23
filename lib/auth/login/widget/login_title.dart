import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';

class LoginTitle extends StatelessWidget {
  final bool isSmallScreen;

  const LoginTitle({
    super.key,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        S.of(context).login,
        style: TextStyle(
          fontFamily: 'NotoSansLao',
          fontSize: isSmallScreen ? 20 : 24,
          fontWeight: FontWeight.bold,
          color: AppColors.color1,
        ),
      ),
    );
  }
}