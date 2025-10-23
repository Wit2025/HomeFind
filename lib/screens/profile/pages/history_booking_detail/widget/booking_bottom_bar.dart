import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/bill/bill_page.dart';
import 'package:homefind/widgets/colors.dart';

class BookingBottomBar extends StatelessWidget {
  final Map<String, String> booking;

  const BookingBottomBar({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
                    color: Colors.teal.withValues(alpha: 0.3),
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
                        bookingId: booking['id'] ?? 'B123456',
                        customerName: booking['customerName'] ?? 'Guest',
                        title: booking['title'] ?? '',
                        bookingFee:
                            double.tryParse(booking['price'] ?? '0') ?? 0.0,
                        currency: 'LAK',
                        createdAt:
                            DateTime.tryParse(booking['date'] ?? '') ??
                            DateTime.now(),
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
                  S.of(context).receipt,
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
    );
  }
}
