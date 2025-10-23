import 'package:flutter/material.dart';
import 'package:homefind/widgets/colors.dart';

class GradientButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double height;
  final double fontSize;
  final double borderRadius;

  const GradientButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height = 50,
    this.fontSize = 16,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          minimumSize: Size(width ?? double.infinity, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.color1,
                AppColors.color2,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Container(
            width: width ?? double.infinity,
            height: height,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}