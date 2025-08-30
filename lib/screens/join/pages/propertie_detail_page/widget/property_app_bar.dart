// widgets/property_app_bar.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class PropertyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color primaryColor;
  final Color darkPrimaryColor;

  const PropertyAppBar({
    super.key,
    required this.primaryColor,
    required this.darkPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        S.of(context).accommodation_info,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, darkPrimaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}