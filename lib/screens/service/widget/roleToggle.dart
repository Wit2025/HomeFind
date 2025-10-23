// lib/components/role_toggle.dart
import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';

class RoleToggle extends StatelessWidget {
  final bool isTechnicianMode;
  final ValueChanged<bool> onChanged;

  const RoleToggle({
    Key? key,
    required this.isTechnicianMode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // User Icon
          _buildToggleItem(
            icon: Icons.person_outline,
            isActive: !isTechnicianMode,
            onTap: () => onChanged(false),
          ),

          const SizedBox(width: 2),

          // Tech Icon
          _buildToggleItem(
            icon: Icons.handyman_outlined,
            isActive: isTechnicianMode,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isActive
              ? LinearGradient(colors: [AppColors.color1, AppColors.color2])
              : null,
          color: isActive ? null : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 18.0,
          color: isActive ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }
}
