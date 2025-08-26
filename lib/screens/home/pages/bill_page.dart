import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:intl/intl.dart';

// คลาสตัดรอยเว้าที่แก้ไขแล้ว
class PositionedOvalClipper extends CustomClipper<Path> {
  final double positionY; // 0.0 (top) to 1.0 (bottom)
  final double radius;

  const PositionedOvalClipper({
    this.positionY = 0.95, // Default near bottom
    this.radius = 20,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final yPos = size.height * positionY;
    final notchRadius = radius;

    // 1. Draw the top section
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, yPos - notchRadius);

    // 2. Draw the right side indentation (semi-circle cutout)
    path.arcToPoint(
      Offset(size.width, yPos + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // 3. Draw the bottom section
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, yPos + notchRadius);

    // 4. Draw the left side indentation (semi-circle cutout)
    path.arcToPoint(
      Offset(0, yPos - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant PositionedOvalClipper oldClipper) =>
      oldClipper.positionY != positionY || oldClipper.radius != radius;
}

class DashedDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashSpace;

  const DashedDivider({
    Key? key,
    this.color = Colors.grey,
    this.height = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              );
            }),
          );
        },
      ),
    );
  }
}

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
    final theme = Theme.of(context);

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
          // height: MediaQuery.of(context).size.height,
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
                // Big success icon with bounce-in animation
                ScaleTransition(
                  scale: _scale,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 44,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.check_rounded,
                        size: 48,
                        color: AppColors.color1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  // 'Booking Successful!',
                  S.of(context).bookingSuccess,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  // 'Thank you, ${widget.customerName}',
                  '${S.of(context).thankYou}, ${widget.customerName}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                // Glass card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ClipPath(
                    clipper: PositionedOvalClipper(positionY: 0.85, radius: 16),
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: _FrostedCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Center(
                              child: Text(
                                // 'Payment Receipt',
                                S.of(context).paymentReceipt,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              // 'Receipt No: #${0001}',
                              S.of(context).receiptNo(0001),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 6),
                            const DashedDivider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                            const SizedBox(height: 12),

                            /// --- Service Details ---
                            Row(
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  color: AppColors.color1,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  // 'Service Details',
                                  S.of(context).serviceDetails,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // _titleRow('Service Name', widget.title),
                            _titleRow(S.of(context).serviceName, widget.title),
                            // _titleRow('Booking ID', widget.bookingId),
                            _titleRow(
                              S.of(context).bookingId,
                              widget.bookingId,
                            ),
                            // _titleRow('Customer', widget.customerName),
                            _titleRow(
                              S.of(context).customer,
                              widget.customerName,
                            ),
                            _titleRow(
                              // 'Date',
                              S.of(context).date,
                              DateFormat(
                                'dd/MM/yyyy HH:mm',
                              ).format(widget.createdAt),
                            ),

                            const SizedBox(height: 12),
                            const DashedDivider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                            const SizedBox(height: 8),

                            /// --- Payment Summary ---
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: AppColors.color1,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  // 'Payment Summary',
                                  S.of(context).paymentSummary,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _amountRow(
                              // 'Booking Fee',
                              S.of(context).booking_fee,
                              _money.format(widget.bookingFee),
                              widget.currency,
                            ),
                            _amountRow(
                              // 'Service Charge',
                              S.of(context).serviceCharge,
                              _money.format(0),
                              widget.currency,
                            ),

                            // _amountRow(
                            //   'Payment Method',
                            //   widget.paymentMethod,
                            //   '',
                            // ), // << เพิ่มตรงนี้
                            const SizedBox(height: 12),
                            const DashedDivider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // 'Grand Total',
                                  S.of(context).grandTotal,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _money.format(50000),
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.color1,
                                          ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.currency,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(color: AppColors.color1),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 64),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: const DashedDivider(
                                color: Colors.grey,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Text(
                                // 'Thank You',
                                S.of(context).thankYou,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.home_rounded),
                          // label:  Text('Back Home'),
                          label: Text(S.of(context).backHome),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.color1,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 2,
                          ),
                          onPressed: () {
                            // In a real app, implement share or download receipt here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                // content: Text('Receipt saved'),
                                content: Text(S.of(context).receiptSaved),
                                backgroundColor: AppColors.color2,
                              ),
                            );
                          },
                          icon: const Icon(Icons.download_rounded),
                          // label: const Text('Save Receipt'),
                          label: Text(S.of(context).saveReceipt),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }

  Widget _amountRow(String label, String amount, String currency) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          Row(
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(width: 6),
              Text(currency),
            ],
          ),
        ],
      ),
    );
  }
}

/// A reusable frosted-glass effect card
class _FrostedCard extends StatelessWidget {
  final Widget child;
  const _FrostedCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.7)),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
