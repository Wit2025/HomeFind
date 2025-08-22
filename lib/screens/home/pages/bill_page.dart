import 'package:flutter/material.dart';
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
        elevation: 0,
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
              colors: [Color(0XFF00B8D1), Color(0XFF005E6B)],
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
                  'Thank you, ${widget.customerName}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
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
                      height: MediaQuery.of(context).size.height * 0.55,
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
                                'Payment Receipt',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Receipt No: #${0001}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 6),
                            const DashedDivider(color: Colors.grey, height: 1.5),
                            const SizedBox(height: 12),
                      
                            /// --- Service Details ---
                            Row(
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  color: Colors.teal,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Service Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _titleRow('Service Name', widget.title),
                            _titleRow('Booking ID', widget.bookingId),
                            _titleRow('Customer', widget.customerName),
                            _titleRow(
                              'Date',
                              DateFormat(
                                'dd/MM/yyyy HH:mm',
                              ).format(widget.createdAt),
                            ),
                      
                            const SizedBox(height: 12),
                            const DashedDivider(color: Colors.grey, height: 1.5),
                            const SizedBox(height: 8),
                      
                            /// --- Payment Summary ---
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: Colors.teal,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Payment Summary',
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
                              'Booking Fee',
                              _money.format(widget.bookingFee),
                              widget.currency,
                            ),
                            _amountRow(
                              'Service Charge',
                              _money.format(0),
                              widget.currency,
                            ),
                      
                            // _amountRow(
                            //   'Payment Method',
                            //   widget.paymentMethod,
                            //   '',
                            // ), // << เพิ่มตรงนี้
                            const SizedBox(height: 12),
                            const DashedDivider(color: Colors.grey, height: 1.5),
                            const SizedBox(height: 12),
                      
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
                                      _money.format(50000),
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.teal[700],
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.currency,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(color: Colors.teal[700]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      
                            const SizedBox(height: 35),
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
                              child: const Text(
                                'Thank You',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
                                content: Text('Receipt saved (demo).'),
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


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Add this import
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:barcode_widget/barcode_widget.dart';

// class BillPage extends StatelessWidget {
//   Future<void> _scanBarcode(BuildContext context) async {
//     try {
//       final barcode = await FlutterBarcodeScanner.scanBarcode(
//         '#FF000000', // Scanner line color
//         'Cancel', // Cancel button text
//         true, // Show flash option
//         ScanMode.BARCODE,
//       );

//       if (barcode == '-1') {
//         // User canceled
//         return;
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(barcode == 'CDR45HGJF' 
//               ? 'Valid receipt scanned!' 
//               : 'Scanned: $barcode'),
//           backgroundColor: barcode == 'CDR45HGJF' ? Colors.green : Colors.blue,
//         ),
//       );
//     } on PlatformException catch (e) { // Now properly typed
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to scan: ${e.message}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Receipt'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // Product Image
//             Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage('https://via.placeholder.com/200'),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Barcode Section
//             Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     Text('ORDER BARCODE', 
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         )),
//                     SizedBox(height: 15),
//                     GestureDetector(
//                       onTap: () => _scanBarcode(context),
//                       child: BarcodeWidget(
//                         barcode: Barcode.code128(),
//                         data: 'CDR45HGJF',
//                         width: 250,
//                         height: 100,
//                         color: Colors.black,
//                         backgroundColor: Colors.transparent,
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Text('CDR45HGJF', 
//                         style: TextStyle(
//                           letterSpacing: 2,
//                           fontSize: 16,
//                         )),
//                     SizedBox(height: 10),
//                     ElevatedButton.icon(
//                       icon: Icon(Icons.qr_code_scanner, size: 20),
//                       label: Text('Scan Barcode'),
//                       style: ElevatedButton.styleFrom(
//                         // primary: Colors.blue[700],
//                         backgroundColor: Colors.blue.shade700,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       onPressed: () => _scanBarcode(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Product Photo
//             _buildProductImage(),
//             SizedBox(height: 20),
            
//             // Coffee Item
//             _buildCoffeeItem(),
//             SizedBox(height: 24),
            
//             // Barcode with scan functionality
//             // _buildBarcode(context),
//             // SizedBox(height: 24),
            
//             // Order Details
//             _buildOrderDetails(),
//             SizedBox(height: 24),
            
//             // Payment Summary
//             _buildPaymentSummary(),
//             SizedBox(height: 32),
            
//             // Download Button
//             _buildDownloadButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductImage() {
//     return Center(
//       child: Container(
//         width: 200,
//         height: 200,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.grey[200],
//           image: DecorationImage(
//             image: NetworkImage('https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500&auto=format&fit=crop&q=60'),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBarcode(BuildContext context) {
//   return Column(
//     children: [
//       Text(
//         'Order Barcode',
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey[700],
//         ),
//       ),
//       SizedBox(height: 8),
//       GestureDetector(
//         onTap: () => _scanBarcode(context),
//         child: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.brown),
//           ),
//           child: Column(
//             children: [
//               // Replace the Icon with BarcodeWidget
//               BarcodeWidget(
//                 barcode: Barcode.code128(),
//                 data: 'CDR45HGJF',
//                 width: 200,
//                 height: 80,
//                 color: Colors.black,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Tap to Scan',
//                 style: TextStyle(
//                   color: Colors.brown,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       SizedBox(height: 8),
//       Text(
//         'CDR45HGJF',
//         style: TextStyle(
//           fontSize: 16,
//           letterSpacing: 2,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   );
// }

//   Widget _buildCoffeeItem() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Cappuccino',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Coffee | Qty.: 02',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey[600],
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'by The Daily Grind Hub',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.brown[700],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOrderDetails() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           _buildDetailRow('Order ID', 'CDR45HGJF'),
//           _buildDetailRow('Order Type', 'Delivery'),
//           _buildDetailRow('Delivery Address', 'Home (1901 Thornridge..)'),
//           _buildDetailRow('Order Date', 'Dec 27, 2023 | 10:00 AM'),
//           _buildDetailRow('Coupon Code', 'CF45AA2024'),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[700],
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentSummary() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           _buildPaymentRow('Sub Total', '\$19.50'),
//           _buildPaymentRow('Taxes', '+\$02.00', isPositive: true),
//           _buildPaymentRow('Delivery Charge', '+\$00.00', isPositive: true),
//           _buildPaymentRow('Discount', '-\$00.00', isNegative: true),
//           _buildPaymentRow('50 Points', '-\$05.00', isNegative: true),
//           SizedBox(height: 12),
//           Divider(thickness: 1),
//           SizedBox(height: 12),
//           _buildPaymentRow('Total', '\$16.50', isTotal: true),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentRow(String label, String value, 
//       {bool isPositive = false, bool isNegative = false, bool isTotal = false}) {
//     Color textColor = Colors.black;
//     if (isPositive) textColor = Colors.green;
//     if (isNegative) textColor = Colors.red;
//     if (isTotal) textColor = Colors.brown[800]!;

//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               color: Colors.grey[700],
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               color: textColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDownloadButton(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle download receipt
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Receipt downloaded successfully')),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           backgroundColor: Colors.brown[800],
//         ),
//         child: Text(
//           'Download E-Receipt',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }