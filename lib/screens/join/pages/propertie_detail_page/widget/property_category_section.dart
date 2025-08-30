// widgets/property_category_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_constants.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_translations.dart';

class PropertyCategorySection extends StatelessWidget {
  final int selectedCategoryIndex;
  final Function(int index, String category) onCategorySelected;

  const PropertyCategorySection({
    super.key,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).service_type,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Container(
            height: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.8,
                ),
                itemCount: PropertyConstants.categories.length,
                itemBuilder: (context, index) {
                  final category = PropertyConstants.categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildCategoryButton(
                      context,
                      category['title'],
                      category['icon'],
                      selectedCategoryIndex == index,
                      index,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String title,
    IconData icon,
    bool isSelected,
    int index,
  ) {
    return GestureDetector(
      onTap: () => onCategorySelected(index, title),
      child: Semantics(
        button: true,
        selected: isSelected,
        label:
            '${S.of(context).category} ${PropertyTranslations.translateValue(title, context)}',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal.shade100 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(color: Colors.teal.shade200, width: 1)
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.teal : Colors.grey,
                size: 27,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(
                PropertyTranslations.translateValue(
                  title,
                  context,
                ), // Display translated text
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
