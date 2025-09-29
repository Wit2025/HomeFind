import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';

class SearchBarSection extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const SearchBarSection({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.color1, width: 2),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'ຄົ້ນຫາບໍລິການ...',
          hintStyle: TextStyle(color: AppColors.color1),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: AppColors.accent2),
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged('');
                  },
                )
              : Icon(Icons.search, color: AppColors.color1, size: 30),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
        ),
        style: TextStyle(color: AppColors.color1),
        cursorColor: AppColors.color1,
        onChanged: onSearchChanged,
      ),
    );
  }
}
