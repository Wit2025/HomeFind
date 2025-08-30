import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homefind/auth/login_check/auth_check.dart';
import 'package:homefind/screens/home/pages/booking/booking_page.dart';
import 'package:homefind/screens/home/pages/product_details/widget/product_booking_button.dart';
import 'package:homefind/screens/home/pages/product_details/widget/product_details_content.dart';
import 'package:homefind/screens/home/pages/product_details/widget/product_image_carousel.dart';
import 'package:homefind/screens/home/pages/product_details/widget/product_thumbnail_list.dart';
import 'package:intl/intl.dart';


class Productdetails extends StatefulWidget {
  final String title;
  final String location;
  final String date;
  final double price;
  final String views;
  final String image;
  final String category;
  final String status;
  final String? currency;
  final String? rental;

  Productdetails({
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    required this.views,
    required this.image,
    required this.category,
    required this.status,
    this.rental,
    this.currency,
    super.key,
  });

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails>
    with TickerProviderStateMixin {
  double bookingFee = 50000;

  int currentImageIndex = 0;
  bool isLiked = false;
  final CarouselSliderController _controller = CarouselSliderController();
  final ScrollController _thumbnailScrollController = ScrollController();
  Timer? autoPlayTimer;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  final format = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    autoPlayTimer?.cancel();
    _animationController.dispose();
    _thumbnailScrollController.dispose();
    super.dispose();
  }

  void goToImage(int index) {
    _controller.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Auto-scroll thumbnails to keep active thumbnail visible
  void _scrollThumbnailToIndex(int index) {
    if (_thumbnailScrollController.hasClients) {
      const double thumbnailWidth = 92.0; // 80 width + 12 margin
      final double targetOffset = index * thumbnailWidth;
      final double maxScrollExtent =
          _thumbnailScrollController.position.maxScrollExtent;
      final double viewportWidth = MediaQuery.of(context).size.width;

      // Calculate the offset to center the thumbnail
      double centeredOffset =
          targetOffset - (viewportWidth / 2) + (thumbnailWidth / 2);
      centeredOffset = centeredOffset.clamp(0.0, maxScrollExtent);

      _thumbnailScrollController.animateTo(
        centeredOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<String> getHotelImages() {
    return [
      widget.image,
      "assets/images/b1.jpg",
      "assets/images/b2.jpg",
      "assets/images/b3.jpg",
      "assets/images/b4.jpg",
      "assets/images/b5.jpg",
      "assets/images/b6.jpg",
      "assets/images/b7.jpg",
      "assets/images/b8.jpg",
      "assets/images/b9.jpg",
      "assets/images/b10.jpg",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final hotelImages = getHotelImages();

    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Enhanced App Bar with gradient
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ProductImageCarousel(
                hotelImages: hotelImages,
                controller: _controller,
                currentImageIndex: currentImageIndex,
                isLiked: isLiked,
                image: widget.image,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentImageIndex = index;
                  });
                  _scrollThumbnailToIndex(index);
                },
                onLikeToggle: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
              ),
            ),
          ),

          // Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Enhanced Thumbnail section with auto-sync
              ProductThumbnailList(
                hotelImages: hotelImages,
                currentImageIndex: currentImageIndex,
                controller: _thumbnailScrollController,
                onThumbnailTap: goToImage,
              ),

              // Elegant dot indicator
              ProductDotIndicator(
                currentImageIndex: currentImageIndex,
                itemCount: hotelImages.length,
                onDotClicked: goToImage,
              ),

              // Enhanced details section with animation
              ProductDetailsContent(
                slideAnimation: _slideAnimation,
                title: widget.title,
                status: widget.status,
                category: widget.category,
                location: widget.location,
                date: widget.date,
                views: widget.views,
                price: widget.price,
                currency: widget.currency,
                rental: widget.rental,
                format: format,
              ),
            ]),
          ),
        ],
      ),

      // Enhanced bottom navigation bar
      bottomNavigationBar: ProductBookingButton(
        onPressed: () {
          AuthChecker.checkAuthAndNavigate(
            context: context,
            page: BookingPage(
              title: widget.title,
              price: widget.price,
              currency: widget.currency,
              rental: widget.rental,
            ),
            showLoginPrompt: true,
          );
        },
      ),
    );
  }
}