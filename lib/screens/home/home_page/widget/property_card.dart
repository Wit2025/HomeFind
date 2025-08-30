// widgets/property_card.dart
import 'package:flutter/material.dart';
import 'package:homefind/screens/home/home_page/widget/property_model.dart';
import 'package:homefind/screens/home/home_page/widget/translation_utils.dart';
import 'package:intl/intl.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/product_details/productDetail.dart';

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildPropertyImage(context), _buildPropertyInfo(context)],
      ),
    );
  }

  Widget _buildPropertyImage(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () => _navigateToDetails(context),
                  child: Image.asset(
                    property.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              size: 40,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(height: 8),
                            Text(
                              S.of(context).no_image,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  TranslationUtils.translateCategory(
                    property.category,
                    context,
                  ),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyInfo(BuildContext context) {
    final formattedPrice = NumberFormat(
      "#,##0.00",
      "en_US",
    ).format(property.priceAsDouble);

    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    property.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  TranslationUtils.translateStatus(property.status, context),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: property.status == 'ຂາຍ' ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 15, color: Colors.blueGrey),
                Expanded(
                  child: Text(
                    property.location,
                    style: TextStyle(color: Colors.black, fontSize: 10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.timer, size: 12, color: Colors.blueGrey),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${S.of(context).daysAgo(property.date)}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                SizedBox(width: 5),
                Row(
                  children: [
                    Icon(Icons.visibility, size: 12, color: Colors.grey),
                    SizedBox(width: 2),
                    Text(
                      property.views,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$formattedPrice ${property.currency ?? "LAK"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (property.status == 'ເຊົ່າ' &&
                            property.rental != null &&
                            property.rental!.isNotEmpty) ...[
                          WidgetSpan(child: SizedBox(width: 5)),
                          TextSpan(
                            text: TranslationUtils.translateRental(
                              property.rental!,
                              context,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Productdetails(
          title: property.title,
          location: property.location,
          date: property.date,
          price: property.priceAsDouble,
          views: property.views,
          image: property.image,
          category: property.category,
          status: property.status,
          currency: property.currency,
          rental: property.rental,
        ),
      ),
    );
  }
}
