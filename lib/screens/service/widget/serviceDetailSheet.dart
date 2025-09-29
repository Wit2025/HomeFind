import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefind/screens/service/chat/chatService.dart';
import 'package:homefind/screens/service/widget/serviceModel.dart';
import 'package:homefind/widgets/Colors.dart';

class ServiceDetailsSheet {
  static void show({
    required BuildContext context,
    required ServiceMarker marker,
    required MapController mapController,
  }) {
    ServiceType serviceType = ServiceData.getServiceType(marker.type);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(marker, serviceType),

                    const SizedBox(height: 24),

                    // Description
                    _buildDescription(marker),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),

                    // Info Cards
                    _buildInfoCards(marker, serviceType),

                    const SizedBox(height: 24),

                    // Action Buttons
                    _buildActionButtons(
                      context,
                      marker,
                      serviceType,
                      mapController,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildHeader(ServiceMarker marker, ServiceType serviceType) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.color1.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(serviceType.icon, color: AppColors.color1, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                marker.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                serviceType.name,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    marker.rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildDescription(ServiceMarker marker) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ລາຍລະອຽດ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          marker.description,
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
      ],
    );
  }

  static Widget _buildInfoCards(ServiceMarker marker, ServiceType serviceType) {
    return Column(
      children: [
        _buildInfoCard(
          Icons.phone,
          'ເບີໂທ',
          marker.phoneNumber,
          AppColors.color1,
        ),
        const SizedBox(height: 12),
        _buildInfoCard(
          Icons.attach_money,
          'ລາຄາບໍລິການ',
          marker.price,
          AppColors.color1,
        ),
        const SizedBox(height: 12),
        _buildInfoCard(
          Icons.access_time,
          'ເວລາເປີດບໍລິການ',
          marker.workingHours,
          AppColors.color1,
        ),
        const SizedBox(height: 12),
        _buildInfoCard(
          Icons.location_on,
          'ພິກັດ',
          '${marker.position.latitude.toStringAsFixed(4)}, ${marker.position.longitude.toStringAsFixed(4)}',
          AppColors.color1,
        ),
      ],
    );
  }

  static Widget _buildInfoCard(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildActionButtons(
    BuildContext context,
    ServiceMarker marker,
    ServiceType serviceType,
    MapController mapController,
  ) {
    return Row(
      children: [
        // Message button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    serviceId: marker.id,
                    serviceName: marker.name,
                    serviceType: marker.type,
                    serviceIcon: serviceType.icon,
                  ),
                ),
              );
            },
            icon: Icon(FontAwesomeIcons.comments),
            label: const Text('ສົ່ງຂໍ້ຄວາມ'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.color1,
              side: const BorderSide(color: AppColors.color1, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Call button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.call),
            label: const Text('ໂທ'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.color1,
              side: const BorderSide(color: AppColors.color1, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Directions button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              mapController.move(marker.position, 17);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.directions),
            label: const Text('ເບິ່ງເສັ້ນທາງ'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
