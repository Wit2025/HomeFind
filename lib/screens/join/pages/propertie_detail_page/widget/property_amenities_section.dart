// widgets/property_amenities_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_constants.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_translations.dart';

class PropertyAmenitiesSection extends StatelessWidget {
  final Color primaryColor;
  final Map<String, bool> amenities;
  final Function(String amenity, bool value) onAmenityChanged;

  const PropertyAmenitiesSection({
    super.key,
    required this.primaryColor,
    required this.amenities,
    required this.onAmenityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).facilities,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3,
          ),
          itemCount: amenities.length,
          itemBuilder: (context, index) {
            final amenity = amenities.keys.elementAt(index);
            final isSelected = amenities[amenity]!;

            return GestureDetector(
              onTap: () => onAmenityChanged(amenity, !isSelected),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PropertyConstants.getAmenityIcon(amenity),
                      color: isSelected ? Colors.white : primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        PropertyTranslations.translateValue(amenity, context), // Display translated amenity
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}