import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final TextStyle? textStyle;
  final bool isLoading;
  final Widget? icon;

  const GradientButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: onPressed != null
            ? const LinearGradient(
                colors: [AppColors.color1, AppColors.color2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : LinearGradient(
                colors: [Colors.grey.shade400, Colors.grey.shade500],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        boxShadow: onPressed != null
            ? [
                const BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: textStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}