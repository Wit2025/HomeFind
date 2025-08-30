import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_card_widget.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_data.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_filter_widget.dart';
import 'package:homefind/screens/profile/pages/history_booking/widget/booking_helper.dart';
import 'package:homefind/screens/profile/pages/history_booking_detail/history_booking_detail.dart';
import 'package:homefind/widgets/Colors.dart';

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

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(l10n),
      body: Column(
        children: [_buildFilterSection(l10n), _buildBookingGrid(l10n)],
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

  Widget _buildBookingGrid(S l10n) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: _filteredBookings.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
