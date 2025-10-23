import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductThumbnailList extends StatelessWidget {
  final List<String> hotelImages;
  final int currentImageIndex;
  final ScrollController controller;
  final Function(int) onThumbnailTap;

  const ProductThumbnailList({
    super.key,
    required this.hotelImages,
    required this.currentImageIndex,
    required this.controller,
    required this.onThumbnailTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: hotelImages.length,
        itemBuilder: (context, index) {
          bool isSelected = index == currentImageIndex;
          return GestureDetector(
            onTap: () => onThumbnailTap(index),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 80,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 3,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    Image.asset(
                      hotelImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    // Overlay for selected thumbnail
                    if (isSelected)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductDotIndicator extends StatelessWidget {
  final int currentImageIndex;
  final int itemCount;
  final Function(int) onDotClicked;

  const ProductDotIndicator({
    super.key,
    required this.currentImageIndex,
    required this.itemCount,
    required this.onDotClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Center(
        child: AnimatedSmoothIndicator(
          activeIndex: currentImageIndex,
          count: itemCount,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.blue,
            dotColor: Colors.grey.shade300,
            expansionFactor: 4,
            spacing: 8,
          ),
          onDotClicked: onDotClicked,
        ),
      ),
    );
  }
}
