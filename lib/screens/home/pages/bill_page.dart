import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BillPage extends StatefulWidget {
  final String bookingId;
  final String name;
  final String category;
  final String amount;
  final DateTime bookingDate;
  // final File? receiptImage;

  const BillPage({
    super.key,
    required this.bookingId,
    required this.name,
    required this.category,
    required this.amount,
    required this.bookingDate,
    // this.receiptImage,
  });

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  bool _isDownloading = false;

  void _downloadBill() async {
    setState(() {
      _isDownloading = true;
    });

    // Simulate download delay
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isDownloading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text('ດາວໂຫລດບິນສຳເລັດແລ້ວ')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _copyBookingId() {
    Clipboard.setData(ClipboardData(text: widget.bookingId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text('ຄັດລອກລະຫັດການຈອງແລ້ວ')),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatTime(DateTime date) {
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ບິນການຈອງ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 87, 167, 177),
                Color.fromARGB(255, 12, 105, 122),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(child: Text('ແບ່ງປັນບິນ')),
                  backgroundColor: Colors.blue,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Success Status
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.teal,
                      size: 80,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ການຈອງສຳເລັດແລ້ວ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ຂໍ້ມູນການຈອງຂອງທ່ານໄດ້ຖືກບັນທຶກແລ້ວ',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Booking Details Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long, color: Colors.teal, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'ລາຍລະອຽດການຈອງ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Booking ID
                  _buildDetailRow(
                    'ລະຫັດການຈອງ',
                    widget.bookingId,
                    showCopy: true,
                  ),
                  _buildDetailRow('ຊື່', widget.name),
                  _buildDetailRow('ປະເພດ', widget.category),

                  _buildDetailRow('ວັນທີ່ຈອງ', _formatDate(widget.bookingDate)),

                  _buildDetailRow('ເວລາຈອງ', _formatTime(widget.bookingDate)),

                  _buildDetailRow('ສະຖານະ', 'ຢືນຢັນແລ້ວ', isStatus: true),

                  Divider(height: 30, thickness: 1),

                  // Amount Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ຄ່າຈອງທັງໝົດ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.teal.shade200),
                        ),
                        child: Text(
                          '₭ ${widget.amount} ກິບ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),
                  Divider(height: 30, thickness: 1),
                  SizedBox(height: 5),

                  // QR Code Section
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 280,
                          width: 230,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade50.withOpacity(0.8),
                                Colors.purple.shade50.withOpacity(0.8),
                                Colors.pink.shade50.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Background watermark text
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.1,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        for (int i = 0; i < 8; i++)
                                          Expanded(
                                            child: Row(
                                              children: [
                                                for (int j = 0; j < 3; j++)
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        'HOME FIND',
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
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

                              // Main content
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    // Header with logo
                                    Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF005E6B),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Home Find',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF005E6B),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          child: Text(
                                            'Verified',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 15),

                                    // QR Code
                                    Container(
                                      height: 180,
                                      width: 180,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: QrImageView(
                                        data: widget.bookingId,
                                        version: QrVersions.auto,
                                        size: 160.0,
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(
                                          0xFF005E6B,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Payment Receipt Card
            // if (widget.receiptImage != null) ...[
            //   Container(
            //     padding: EdgeInsets.all(20),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(16),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.1),
            //           blurRadius: 10,
            //           offset: Offset(0, 2),
            //         ),
            //       ],
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: [
            //             Icon(
            //               Icons.image,
            //               color: Colors.blue,
            //               size: 24,
            //             ),
            //             SizedBox(width: 12),
            //             Text(
            //               'ສຳເນົາການໂອນເງິນ',
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.grey[800],
            //               ),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 16),
            //         Container(
            //           height: 200,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             border: Border.all(color: Colors.grey.shade300),
            //             image: DecorationImage(
            //               image: FileImage(widget.receiptImage!),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   SizedBox(height: 20),
            // ],

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isDownloading ? null : _downloadBill,
                    icon: _isDownloading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Icon(Icons.download, color: Colors.white),
                    label: Text(
                      _isDownloading ? 'ກຳລັງດາວໂຫລດ...' : 'ດາວໂຫລດບິນ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005E6B),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Print functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(child: Text('ພິມບິນ')),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    },
                    icon: Icon(Icons.print, color: Colors.black),
                    label: Text(
                      'ພິມບິນ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.teal, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Footer Note
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Colors.blueGrey, size: 20),
                  SizedBox(width: 12),
                  Text(
                    'ກະລຸນາເກັບຮັກສາບິນນີ້ໄວ້ເປັນຫຼັກຖານການຈອງ',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool showCopy = false,
    bool isStatus = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Row(
            children: [
              if (isStatus)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade900,
                    ),
                  ),
                )
              else
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              if (showCopy) ...[
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _copyBookingId,
                  child: Icon(Icons.copy, size: 18, color: Colors.teal),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
