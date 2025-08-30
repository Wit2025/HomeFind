import 'package:flutter/material.dart';
import 'package:homefind/screens/home/pages/bill/widget/bill_bottom_button.dart';
import 'package:homefind/screens/home/pages/bill/widget/bill_header.dart';
import 'package:homefind/screens/home/pages/bill/widget/bill_receipt_card.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:intl/intl.dart';

/// Modern, animated Bill Page for a successful booking/checkout
class BillPage extends StatefulWidget {
  final String bookingId;
  final String customerName;
  final String title;
  final double bookingFee;
  final String currency; // e.g. "LAK", "THB", "USD"
  final DateTime createdAt;

  BillPage({
    super.key,
    required this.bookingId,
    required this.customerName,
    required this.title,
    required this.bookingFee,
    this.currency = 'LAK',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final NumberFormat _money;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();

    // Change locale if you want Lao/Thai grouping rules, e.g. 'lo_LA' or 'th_TH'
    _money = NumberFormat('#,##0.00', 'en_US');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [AppColors.color1, AppColors.color2],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header with success icon and text
                BillHeader(
                  scale: _scale,
                  customerName: widget.customerName,
                ),

                const SizedBox(height: 16),

                // Receipt Card
                BillReceiptCard(
                  title: widget.title,
                  bookingId: widget.bookingId,
                  customerName: widget.customerName,
                  createdAt: widget.createdAt,
                  bookingFee: widget.bookingFee,
                  currency: widget.currency,
                  money: _money,
                ),

                // Bottom Buttons
                const BillBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}