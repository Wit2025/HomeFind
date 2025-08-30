import 'package:flutter/material.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/widget/booking_bottom_bar.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/widget/booking_info_widget.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/widget/booking_untils.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/widget/image_carousel_widget.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/widget/thumnail_list_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BookingDetailPage extends StatefulWidget {
  final Map<String, String> booking;

  const BookingDetailPage({super.key, required this.booking});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage>
    with TickerProviderStateMixin {
  int currentImageIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late List<String> hotelImages;

  @override
  void initState() {
    super.initState();
    hotelImages = BookingUtils.getHotelImages(widget.booking['image']);
    
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
    _animationController.dispose();
    super.dispose();
  }

  void _onImageChanged(int index) {
    setState(() {
      currentImageIndex = index;
    });
  }

  void _onImageTap(int index) {
    // Handle image tap (e.g., show fullscreen image)
    // You can add fullscreen image viewer here
  }

  void _onThumbnailTap(int index) {
    setState(() {
      currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image Carousel
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
            flexibleSpace: FlexibleSpaceBar(
              background: ImageCarouselWidget(
                images: hotelImages,
                onImageChanged: _onImageChanged,
                onImageTap: _onImageTap,
              ),
            ),
          ),
          
          // Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Thumbnail List
              ThumbnailListWidget(
                images: hotelImages,
                currentIndex: currentImageIndex,
                onThumbnailTap: _onThumbnailTap,
              ),
              
              // Page Indicator
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: currentImageIndex,
                    count: hotelImages.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey.shade300,
                      expansionFactor: 4,
                      spacing: 8,
                    ),
                    onDotClicked: (index) {
                      setState(() {
                        currentImageIndex = index;
                      });
                    },
                  ),
                ),
              ),
              
              // Booking Information with Animation
              AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: BookingInfoWidget(booking: widget.booking),
                  );
                },
              ),
            ]),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BookingBottomBar(booking: widget.booking),
    );
  }
}