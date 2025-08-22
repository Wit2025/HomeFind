import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/bill_page.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Status และ Type constants
class BookingStatus {
  static const String completed = 'ສຳເລັດ';
  static const String pending = 'ລໍຖ້າ';
  static const String cancelled = 'ຍົກເລີກ';
}

class BookingType {
  static const String rental = 'ເຊົ່າ';
  static const String sale = 'ຂາຍ';
}

class BookingDetailPage extends StatefulWidget {
  final Map<String, String> booking;

  const BookingDetailPage({super.key, required this.booking});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage>
    with TickerProviderStateMixin {
  int currentImageIndex = 0;
  bool isLiked = false;
  final CarouselSliderController _controller = CarouselSliderController();
  final ScrollController _thumbnailScrollController = ScrollController();
  Timer? autoPlayTimer;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

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

  // Function เพื่อแปลง status เป็นข้อความที่แสดงผล
  String _getStatusDisplayText(String status) {
    switch (status) {
      case BookingStatus.completed:
        return S.of(context).completed;
      case BookingStatus.pending:
        return S.of(context).pending;
      case BookingStatus.cancelled:
        return S.of(context).cancelled;
      default:
        return status;
    }
  }

  // Function เพื่อแปลง type เป็นข้อความที่แสดงผล
  String _getTypeDisplayText(String type) {
    switch (type) {
      case BookingType.rental:
        return S.of(context).rent;
      case BookingType.sale:
        return S.of(context).sale;
      default:
        return type;
    }
  }

  // Function เพื่อกำหนดสีของ status
  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case BookingStatus.completed:
        return Colors.green.shade100;
      case BookingStatus.pending:
        return Colors.orange.shade100;
      case BookingStatus.cancelled:
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  Color _getStatusBorderColor(String status) {
    switch (status) {
      case BookingStatus.completed:
        return Colors.green.shade300;
      case BookingStatus.pending:
        return Colors.orange.shade300;
      case BookingStatus.cancelled:
        return Colors.red.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case BookingStatus.completed:
        return Colors.green.shade700;
      case BookingStatus.pending:
        return Colors.orange.shade700;
      case BookingStatus.cancelled:
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  // Function เพื่อกำหนดสีของ type
  Color _getTypeBackgroundColor(String type) {
    switch (type) {
      case BookingType.rental:
        return Colors.blue.shade50;
      case BookingType.sale:
        return Colors.red.shade50;
      default:
        return Colors.grey.shade50;
    }
  }

  Color _getTypeTextColor(String type) {
    switch (type) {
      case BookingType.rental:
        return Colors.blue.shade700;
      case BookingType.sale:
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  void goToImage(int index) {
    _controller.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollThumbnailToIndex(int index) {
    if (_thumbnailScrollController.hasClients) {
      const double thumbnailWidth = 92.0;
      final double targetOffset = index * thumbnailWidth;
      final double maxScrollExtent =
          _thumbnailScrollController.position.maxScrollExtent;
      final double viewportWidth = MediaQuery.of(context).size.width;

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
      widget.booking['image'] ?? 'assets/images/default.jpg',
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
    final status = widget.booking['status'] ?? BookingStatus.pending;
    final type = widget.booking['type'] ?? BookingType.rental;

    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
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
              background: Stack(
                children: [
                  Hero(
                    tag: 'product-image-${widget.booking['image']}',
                    child: Container(
                      height: 700,
                      child: CarouselSlider.builder(
                        carouselController: _controller,
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
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 800,
                          ),
                          autoPlayCurve: Curves.easeInOutCubic,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentImageIndex = index;
                            });
                            _scrollThumbnailToIndex(index);
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.color1.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isLiked
                              ? Colors.red.withOpacity(0.9)
                              : Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
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
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 65,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListView.builder(
                  controller: _thumbnailScrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: hotelImages.length,
                  itemBuilder: (context, index) {
                    bool isSelected = index == currentImageIndex;
                    return GestureDetector(
                      onTap: () => goToImage(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 80,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Image.asset(
                                hotelImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              if (isSelected)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.2),
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
              ),
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
                      goToImage(index);
                    },
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.booking['title'] ?? '',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusBackgroundColor(status),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _getStatusBorderColor(status),
                                  ),
                                ),
                                child: Text(
                                  _getStatusDisplayText(status),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _getStatusTextColor(status),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _getTypeBackgroundColor(type),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${S.of(context).bookingType}: ${_getTypeDisplayText(type)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _getTypeTextColor(type),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '4.8',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    widget.booking['location'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    widget.booking['date'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).details,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                // 'The breakfast buffet was amazing and very worth it! The location is perfect and the staff was incredibly helpful throughout our stay.',
                                S.of(context).breakfast_review,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.color1, AppColors.color2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillPage(
                          bookingId: widget.booking['id'] ?? 'B123456',
                          customerName:
                              widget.booking['customerName'] ?? 'Guest',
                          title: widget.booking['title'] ?? '',
                          bookingFee:
                              double.tryParse(widget.booking['price'] ?? '0') ??
                              0.0, // ⚠️ ต้องแปลง String เป็น double
                          currency:
                              'LAK', // หรือ widget.booking['currency'] ถ้ามี
                          createdAt:
                              DateTime.tryParse(widget.booking['date'] ?? '') ??
                              DateTime.now(), // ⚠️ ต้องแปลง String เป็น DateTime
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size(140, 54),
                  ),
                  child: Text(
                    S.of(context).receipt, // ต้องเพิ่มใน l10n
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
