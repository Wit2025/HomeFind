import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/bill_page.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:image_picker/image_picker.dart';

class BookingPage extends StatefulWidget {
  final String proname;
  final String category;
  BookingPage({required this.proname, required this.category, super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  File? _image;

  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) return;

    final picker = ImagePicker();
    final pickedFile = await showModalBottomSheet<XFile?>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          key: ValueKey(Localizations.localeOf(context).languageCode),
          child: Container(
            height: 200,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  // 'ເລືອກຮູບພາບ'
                  S.of(context).select_image,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (_isPickingImage) return;
                            _isPickingImage = true;
                            final picked = await picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 80,
                            );
                            _isPickingImage = false;
                            Navigator.pop(context, picked);
                          },
                          child: AbsorbPointer(
                            absorbing: _isPickingImage,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: AppColors.color1.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.color1,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 30,
                                    color: AppColors.color1,
                                  ),
                                  Text(
                                    // 'ແກລເລີຣີ'
                                    S.of(context).gallery,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (_isPickingImage) return;
                            _isPickingImage = true;
                            final picked = await picker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 80,
                            );
                            _isPickingImage = false;
                            Navigator.pop(context, picked);
                          },
                          child: AbsorbPointer(
                            absorbing: _isPickingImage,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: AppColors.color2.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.color2,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                    color: AppColors.color2,
                                  ),
                                  Text(
                                    // 'ກ້ອງຖ່າຍ'
                                    S.of(context).camera,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
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
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text('ຈອງ'),
        // backgroundColor: const Color.fromARGB(255, 87, 167, 177),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // QR Code Section
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
                  Text(
                    // 'ສະແກນ QR Code ເພື່ອຈ່າຍເງິນ'
                    S.of(context).scan_qr_code_payment,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/qr.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Text(
                      // "ຄ່າຈອງ: ₭ 50,000 ກິບ",
                      "${S.of(context).price} ₭ 50,000",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Upload Receipt Section
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
                  Text(
                    // 'ອັບໂຫລດສຳເນົາການໂອນເງິນ'
                    S.of(context).upload_transfer_receipt,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),

                  if (_image != null) ...[
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            // 'ອັບໂຫລດສຳເລັດແລ້ວ',
                            S.of(context).upload_completed,
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _image != null
                            ? Colors.transparent
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _image != null
                              ? Colors.green
                              : Colors.grey.shade300,
                          width: 2,
                          style: _image != null
                              ? BorderStyle.solid
                              : BorderStyle.solid,
                        ),
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 50,
                                  color: Colors.grey[500],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  // 'ແຕະເພື່ອເລືອກຮູບພາບ',
                                  S.of(context).tap_to_select_image,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  // 'JPG, PNG ຫຼື PDF',
                                  S.of(context).file_formats,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              children: [
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Submit Button
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   colors: [Colors.teal.shade400, Colors.teal.shade700],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(20),
          //   topRight: Radius.circular(20),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _image != null
                  ? () async {
                      // Show modern loading dialog
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.color1, AppColors.color2],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 30,
                                  offset: Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.color1,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                    strokeWidth: 3,
                                  ),
                                ),
                                SizedBox(height: 24),
                                Text(
                                  S.of(context).processing,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  S.of(context).please_wait,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context); // Close load
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  BillPage(
                                    bookingId: 'BK-2025-0001',
                                    customerName: 'Phengvar Lee',
                                    proname: widget.proname,
                                    bookingFee: 50000,
                                    currency: 'LAK',
                                  ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return SlideTransition(
                                  position:
                                      Tween<Offset>(
                                        begin: Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOutCubic,
                                        ),
                                      ),
                                  child: child,
                                );
                              },
                          transitionDuration: Duration(milliseconds: 600),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                disabledBackgroundColor: Colors.grey[300],
                elevation: _image != null ? 5 : 0,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.transparent,
              ),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: _image != null
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.color1, AppColors.color2],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )
                    : null,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      S.of(context).confirm_booking,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _image != null ? Colors.white : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
