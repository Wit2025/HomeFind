import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:intl/intl.dart';

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
    return Container(
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

/// Simple bill/receipt item
class BillItem {
  final String pro_name;
  final String category;
  final int qty;
  final double unitPrice;

  const BillItem({
    required this.pro_name,
    required this.category,
    required this.qty,
    required this.unitPrice,
  });

  double get lineTotal => qty * unitPrice;
}

/// Modern, animated Bill Page for a successful booking/checkout
class BillPage extends StatefulWidget {
  final String bookingId;
  final String customerName;
  final String pro_name;
  final String category;
  final List<BillItem> items;
  final String currency; // e.g. "LAK", "THB", "USD"
  final DateTime createdAt;
  final double taxRate; // e.g. 0.07 for 7%

  BillPage({
    super.key,
    required this.bookingId,
    required this.customerName,
    required this.pro_name,
    required this.category,
    required this.items,
    this.currency = 'LAK',
    DateTime? createdAt,
    this.taxRate = 0.0,
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

  double get _subTotal =>
      widget.items.fold(0.0, (sum, it) => sum + it.lineTotal);
  double get _tax => _subTotal * widget.taxRate;
  double get _grandTotal => _subTotal + _tax;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Booking Bill'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.color1, AppColors.color2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),

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
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Text(
                'Booking Successful!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Thank you ${widget.customerName}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 16),

              // Glass card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: _FrostedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _titleRow('Booking ID', widget.bookingId),
                        const SizedBox(height: 6),
                        _titleRow('Customer', widget.customerName),
                        const SizedBox(height: 6),
                        _titleRow(
                          'Date',
                          DateFormat(
                            'yyyy-MM-dd HH:mm',
                          ).format(widget.createdAt),
                        ),
                        const DashedDivider(color: Colors.grey, height: 1.5),
                        const SizedBox(height: 8),
                        Text(
                          'Items',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),

                        if (widget.items.isEmpty)
                          Text('No items', style: theme.textTheme.bodyMedium)
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.items.length,
                            separatorBuilder: (_, __) => const DashedDivider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                            itemBuilder: (context, i) {
                              final it = widget.items[i];
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   it.category,
                                        //   style: theme.textTheme.bodyLarge
                                        //       ?.copyWith(
                                        //         fontWeight: FontWeight.w600,
                                        //       ),
                                        // ),
                                        Text(
                                          it.pro_name,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'x${it.qty} × ${_money.format(it.unitPrice)} ${widget.currency}',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: Colors.grey[600],
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    _money.format(it.lineTotal),
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.currency,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              );
                            },
                          ),

                        const SizedBox(height: 12),
                        const DashedDivider(color: Colors.grey, height: 1.5),

                        _amountRow(
                          'Subtotal',
                          _money.format(_subTotal),
                          widget.currency,
                        ),
                        if (widget.taxRate > 0)
                          _amountRow(
                            'Tax (${(widget.taxRate * 100).toStringAsFixed(0)}%)',
                            _money.format(_tax),
                            widget.currency,
                          ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Grand Total',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  _money.format(_grandTotal),
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.teal[700],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.currency,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.teal[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const DashedDivider(color: Colors.grey, height: 1.5),
                        const SizedBox(height: 30),
                        Center(
                          child: const Text(
                            'Thank You',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
                          side: const BorderSide(color: Colors.white70),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.home_rounded),
                        label: const Text('Back Home'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          // In a real app, implement share or download receipt here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Receipt saved.'),
                              backgroundColor: AppColors.color1,
                            ),
                          );
                        },
                        icon: const Icon(Icons.download_rounded),
                        label: const Text('Save Receipt'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          Text(label),
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

// ------------------ DEMO USAGE ------------------
// Example: Navigate to BillPage after booking success
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => BillPage(
//       bookingId: 'BK-2025-0001',
//       customerName: 'Phengvar Lee',
//       currency: 'LAK',
//       taxRate: 0.07,
//       items: const [
//         BillItem(name: 'Deluxe Room (1 night)', qty: 1, unitPrice: 850000),
//         BillItem(name: 'Airport Pickup', qty: 1, unitPrice: 120000),
//       ],
//     ),
//   ),
// );
