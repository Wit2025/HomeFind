import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_card_widget.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_data.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_filter_widget.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_helper.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/history_booking_detail.dart';
import 'package:homefind/widgets/colors.dart';

class HistoryBookingPages extends StatefulWidget {
  const HistoryBookingPages({super.key});

  @override
  State<HistoryBookingPages> createState() => _HistoryBookingPagesState();
}

class _HistoryBookingPagesState extends State<HistoryBookingPages> {
  String? _selectedStatusFilter;
  String? _selectedTypeFilter;

  List<Map<String, String>> get _filteredBookings {
    return BookingHelper.filterBookings(
      BookingData.getAllBookingsAsMap(),
      _selectedStatusFilter,
      _selectedTypeFilter,
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // โหลดข้อมูลใหม่ (mock data)
      // ถ้าในอนาคตเชื่อม API ก็เรียก API ที่นี่แทน
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(l10n),
      body: Column(
        children: [
          _buildFilterSection(l10n),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.color1,
              onRefresh: _handleRefresh,
              child: _filteredBookings.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text(
                              l10n.no_data, // ถ้ามี string สำหรับ "ไม่มีข้อมูล"
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: _filteredBookings.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.80,
                            ),
                        itemBuilder: (context, index) {
                          final booking = _filteredBookings[index];
                          return BookingCardWidget(
                            booking: booking,
                            l10n: l10n,
                            onTap: () => _navigateToBookingDetail(booking),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(S l10n) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.color1, AppColors.color2],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      title: Text(
        l10n.bookingHistory,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildFilterSection(S l10n) {
    return BookingFilterWidget(
      selectedStatusFilter: _selectedStatusFilter,
      selectedTypeFilter: _selectedTypeFilter,
      onStatusFilterChanged: (String? status) {
        setState(() {
          _selectedStatusFilter = status;
        });
      },
      onTypeFilterChanged: (String? type) {
        setState(() {
          _selectedTypeFilter = type;
        });
      },
      l10n: l10n,
    );
  }

  void _navigateToBookingDetail(Map<String, String> booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingDetailPage(booking: booking),
      ),
    );
  }
}
