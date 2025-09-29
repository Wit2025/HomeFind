// widgets/categories_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/screens/home/home_page/widget/property_data.dart';
import 'package:homefind/screens/home/home_page/widget/property_model.dart';
import 'package:homefind/screens/home/home_page/widget/translation_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:homefind/generated/l10n.dart';

class CategoriesSection extends StatelessWidget {
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;

  const CategoriesSection({
    Key? key,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0.0, -50.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: PropertyData.categories.length,
                  itemBuilder: (context, index) {
                    final category = PropertyData.categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _buildCategoryButton(
                        context,
                        category,
                        selectedCategoryIndex == index,
                        index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: selectedCategoryIndex,
                count: PropertyData.categories.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey.shade300,
                  expansionFactor: 4,
                  spacing: 8,
                ),
                onDotClicked: onCategorySelected,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    Category category,
    bool isSelected,
    int index,
  ) {
    return GestureDetector(
      onTap: () => onCategorySelected(index),
      child: Semantics(
        button: true,
        selected: isSelected,
        label:
            '${S.of(context).category} ${TranslationUtils.translateCategory(category.title, context)}',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal.shade100 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: Colors.teal.shade200, width: 1)
                    : null,
              ),
              child: Icon(
                category.icon,
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
                TranslationUtils.translateCategory(category.title, context),
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
