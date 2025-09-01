import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/bill/bill_page.dart';
import 'package:homefind/screens/home/pages/booking/widget/image_picker_modal.dart';
import 'package:homefind/screens/home/pages/booking/widget/qr_code_section.dart';
import 'package:homefind/screens/home/pages/booking/widget/submit_button.dart';
import 'package:homefind/screens/home/pages/booking/widget/upload_receipt_section.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final String title;
  final double price;
  final String? currency;
  final String? rental;
  BookingPage({
    required this.title,
    required this.price,
    required this.currency,
    this.rental,
    super.key,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final format = NumberFormat("#,##0.00", "en_US");
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
        return ImagePickerModal(
          picker: picker,
          isPickingImage: _isPickingImage,
          onImagePicking: (value) => _isPickingImage = value,
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String _translateRental(String rental) {
    switch (rental) {
      case 'ຕໍ່ປີ':
        return S.of(context).per_y;
      case 'ຕໍ່ເດືອນ':
        return S.of(context).per_m;
      default:
        return rental;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${format.format(widget.price)} ${widget.currency}',
              ),
              TextSpan(text: _translateRental(widget.rental ?? '')),
            ],
          ),
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
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
            QRCodeSection(),
            SizedBox(height: 30),
            // Upload Receipt Section
            UploadReceiptSection(image: _image, onPickImage: _pickImage),
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: SubmitButton(
        image: _image,
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
                Navigator.pop(context); // Close loading
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BillPage(
                          bookingId: 'BK-2025-0001',
                          customerName: 'Phengvar Lee',
                          title: widget.title,
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
        title: widget.title,
      ),
    );
  }
}
