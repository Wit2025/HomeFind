import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/product_details/widget/translation_helper.dart';
import 'package:intl/intl.dart';

class ProductDetailsContent extends StatelessWidget {
  final Animation<double> slideAnimation;
  final String title;
  final String status;
  final String category;
  final String location;
  final String date;
  final String views;
  final double price;
  final String? currency;
  final String? rental;
  final NumberFormat format;

  const ProductDetailsContent({
    super.key,
    required this.slideAnimation,
    required this.title,
    required this.status,
    required this.category,
    required this.location,
    required this.date,
    required this.views,
    required this.price,
    required this.currency,
    required this.rental,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slideAnimation.value),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                    ),
                    // SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            TranslationHelper.translateStatus(
                                  status,
                                  context,
                                ) ==
                                S.of(context).sale
                            ? Colors.red.shade100
                            : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              TranslationHelper.translateStatus(
                                    status,
                                    context,
                                  ) ==
                                  S.of(context).sale
                              ? Colors.red.shade300
                              : Colors.green.shade300,
                        ),
                      ),
                      child: Text(
                        TranslationHelper.translateStatus(status, context),
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              TranslationHelper.translateStatus(
                                    status,
                                    context,
                                  ) ==
                                  S.of(context).sale
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2),

                // Category and rating
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        TranslationHelper.translateCategory(category, context),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Row(
                      children: List.generate(
                        5,
                        (index) =>
                            Icon(Icons.star, color: Colors.amber, size: 18),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Location
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // Date and reviews
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text(
                          S.of(context).daysAgo(date),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            S.of(context).views(views),
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Enhanced review section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).details,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      S.of(context).breakfast_review,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: S.of(context).price,
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              WidgetSpan(child: SizedBox(width: 5)),
                              TextSpan(
                                text: format.format(price),
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextSpan(
                                text: ' $currency',
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              WidgetSpan(child: SizedBox(width: 5)),
                            ],
                          ),
                        ),
                        Text(
                          TranslationHelper.translateRental(
                            rental ?? '',
                            context,
                          ),
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
