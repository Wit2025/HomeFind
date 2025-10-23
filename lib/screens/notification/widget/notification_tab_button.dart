import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/notification/widget/notification_constant.dart';
import 'package:homefind/widgets/colors.dart';

class NotificationTabButton extends StatelessWidget {
  final String tab;
  final bool isSelected;
  final VoidCallback onTap;

  const NotificationTabButton({
    super.key,
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  String _getTabDisplayText(BuildContext context, String tab) {
    switch (tab) {
      case NotificationTabs.unread:
        return S.of(context).unread;
      case NotificationTabs.read:
        return S.of(context).read;
      default:
        return tab;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.color1;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              _getTabDisplayText(context, tab),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}