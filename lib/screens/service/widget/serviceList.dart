import 'package:flutter/material.dart';
import 'package:homefind/screens/service/widget/serviceModel.dart';
import 'package:homefind/widgets/Colors.dart';

class ServiceList extends StatelessWidget {
  final List<ServiceMarker> filteredMarkers;
  final String? selectedServiceType;
  final Function(ServiceMarker) onServiceTap;
  final VoidCallback onClearFilter;

  const ServiceList({
    Key? key,
    required this.filteredMarkers,
    required this.selectedServiceType,
    required this.onServiceTap,
    required this.onClearFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with count and clear filter
          _buildHeader(),

          // Service list
          Expanded(child: _buildServiceList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Service count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.color1,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'ບໍລິການ (${filteredMarkers.length})',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),

          // Clear filter button
          if (selectedServiceType != null)
            TextButton.icon(
              onPressed: onClearFilter,
              icon: const Icon(Icons.clear, size: 14),
              label: const Text('ລ້າງຕົວກອງ', style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 30),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildServiceList() {
    if (filteredMarkers.isEmpty) {
      return const Center(
        child: Text('ບໍ່ມີຂໍ້ມູນບໍລິການ', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: filteredMarkers.length,
      itemBuilder: (context, index) {
        ServiceMarker marker = filteredMarkers[index];
        ServiceType serviceType = ServiceData.getServiceType(marker.type);

        return _buildServiceCard(marker, serviceType);
      },
    );
  }

  Widget _buildServiceCard(ServiceMarker marker, ServiceType serviceType) {
    return GestureDetector(
      onTap: () => onServiceTap(marker),
      child: Container(
        width: 240,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.color1, AppColors.color2],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Service icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: serviceType.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      serviceType.icon,
                      color: serviceType.color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Service info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          marker.name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              marker.rating.toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
