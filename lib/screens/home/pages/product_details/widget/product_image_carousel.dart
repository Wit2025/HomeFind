import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homefind/widgets/colors.dart';

class ProductImageCarousel extends StatelessWidget {
  final List<String> hotelImages;
  final CarouselSliderController controller;
  final int currentImageIndex;
  final bool isLiked;
  final String image;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final VoidCallback onLikeToggle;

  const ProductImageCarousel({
    super.key,
    required this.hotelImages,
    required this.controller,
    required this.currentImageIndex,
    required this.isLiked,
    required this.image,
    required this.onPageChanged,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Enhanced Carousel with Hero animation
        Hero(
          tag: 'product-image-$image',
          child: SizedBox(
            height: 700,
            child: CarouselSlider.builder(
              carouselController: controller,
              itemCount: hotelImages.length,
              itemBuilder: (context, index, realIndex) {
                return Image.asset(
                  hotelImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
              options: CarouselOptions(
                height: 350,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOutCubic,
                onPageChanged: onPageChanged,
              ),
            ),
          ),
        ),

        // Gradient overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.color1.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),

        // Like button with animation
        Positioned(
          bottom: 8,
          left: 8,
          child: GestureDetector(
            onTap: onLikeToggle,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isLiked
                    ? Colors.red.withValues(alpha: 0.9)
                    : Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.white : Colors.red,
                size: 24,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Text(
              '${currentImageIndex + 1}/${hotelImages.length}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
