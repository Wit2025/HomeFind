import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:homefind/screens/service/widget/serviceType.dart';
import 'package:homefind/screens/service/widget/service_location.dart';
import 'package:homefind/screens/service/widget/step1Card.dart';
import 'package:homefind/screens/service/widget/step2Card.dart';
import 'package:homefind/screens/service/widget/step3Card.dart';
import 'package:homefind/screens/service/widget/step4Card.dart';
import 'package:homefind/screens/service/techView/widget/technicianResponse.dart';
import 'package:latlong2/latlong.dart';

class ServiceRequestContent extends StatefulWidget {
  final int currentStep;
  final String? selectedService;
  final double? offerPrice;
  final File? selectedImage;
  final String description;
  final List<ServiceType> services;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final List<TechnicianResponse> technicianResponses;
  final bool hasNewResponses;
  final ServiceLocation? selectedLocation;
  final List<ServiceLocation> locations;
  final Function(int) onStepChanged;
  final Function(String?) onServiceChanged;
  final Function(ServiceLocation?) onLocationChanged;
  final Function(double?) onPriceChanged;
  final Function(File?) onImageChanged;
  final Function(String) onDescriptionChanged;
  final Function(List<TechnicianResponse>, {bool hasNew})
  onTechnicianResponsesChanged;
  final Function() onResetForm;

  const ServiceRequestContent({
    Key? key,
    required this.currentStep,
    required this.selectedService,
    required this.offerPrice,
    required this.selectedImage,
    required this.description,
    required this.services,
    required this.priceController,
    required this.descriptionController,
    required this.technicianResponses,
    required this.hasNewResponses,
    required this.selectedLocation,
    required this.locations,
    required this.onStepChanged,
    required this.onServiceChanged,
    required this.onLocationChanged,
    required this.onPriceChanged,
    required this.onImageChanged,
    required this.onDescriptionChanged,
    required this.onTechnicianResponsesChanged,
    required this.onResetForm,
  }) : super(key: key);

  @override
  State<ServiceRequestContent> createState() => _ServiceRequestContentState();
}

class _ServiceRequestContentState extends State<ServiceRequestContent> {
  LatLng _selectedLocation = LatLng(17.981442, 102.618952);
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full screen map
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _selectedLocation,
            initialZoom: 15.0,
            onTap: (tapPosition, point) {
              if (widget.currentStep == 1) {
                setState(() {
                  _selectedLocation = point;
                });
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              userAgentPackageName: 'com.androidApp.homefind',
              maxZoom: 19,
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _selectedLocation,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Bottom sheet with steps
        DraggableScrollableSheet(
          initialChildSize: 0.35,
          minChildSize: 0.2,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Content based on current step
                      _buildCurrentStep(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (widget.currentStep) {
      case 1:
        return Step1LocationService(
          selectedService: widget.selectedService,
          services: widget.services,
          selectedLocation: widget.selectedLocation,
          locations: widget.locations,
          onServiceChanged: widget.onServiceChanged,
          onLocationChanged: widget.onLocationChanged,
          onNextStep: () => widget.onStepChanged(2),
        );
      case 2:
        return Step2DetailsPrice(
          offerPrice: widget.offerPrice,
          selectedImage: widget.selectedImage,
          selectedLocation: widget.selectedLocation,
          description: widget.description,
          priceController: widget.priceController,
          descriptionController: widget.descriptionController,
          onPriceChanged: widget.onPriceChanged,
          onImageChanged: widget.onImageChanged,
          onDescriptionChanged: widget.onDescriptionChanged,
          onPreviousStep: () => widget.onStepChanged(1),
          onSubmit: _submitRequest,
        );
      case 3:
        return const Step3Waiting();
      case 4:
        return Step4Responses(
          technicianResponses: widget.technicianResponses,
          hasNewResponses: widget.hasNewResponses,
          offerPrice: widget.offerPrice,
          selectedService: widget.selectedService,
          services: widget.services,
          onResetForm: widget.onResetForm,
          onTechnicianResponsesChanged: widget.onTechnicianResponsesChanged,
          onStepChanged: widget.onStepChanged,
        );
      default:
        return Step1LocationService(
          selectedService: widget.selectedService,
          services: widget.services,
          selectedLocation: widget.selectedLocation,
          locations: widget.locations,
          onServiceChanged: widget.onServiceChanged,
          onLocationChanged: widget.onLocationChanged,
          onNextStep: () => widget.onStepChanged(2),
        );
    }
  }

  void _submitRequest() {
    if (widget.selectedService == null ||
        widget.offerPrice == null ||
        widget.selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ກາລຸນາປ້ອນຂໍ້ມູນໃຫ້ຕົບຖ້ວນ')),
      );
      return;
    }

    // จำลองการส่งคำขอ
    Future.delayed(const Duration(seconds: 2), () {
      // Build structured request payload including selected location
      // ignore: unused_local_variable
      final Map<String, dynamic> requestPayload = {
        'service': widget.selectedService,
        'price': widget.offerPrice,
        'description': widget.description,
        'hasImage': widget.selectedImage != null,
        'location': widget.selectedLocation != null
            ? {
                'id': widget.selectedLocation!.id,
                'title': widget.selectedLocation!.title,
                'address': widget.selectedLocation!.address,
                'lat': widget.selectedLocation!.lat,
                'lng': widget.selectedLocation!.lng,
              }
            : null,
      };

      // No simulated technician responses here — the app will display only real responses.
      // Clear any previous responses so Step4 shows only actual responses when they arrive.
      widget.onTechnicianResponsesChanged([], hasNew: false);

      widget.onStepChanged(4);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ຊ່າງໄດ້ຮັບການແຈ້ງເຕືອນແລ້ວ  ກຳລັງລໍຖ້າການຕອບຮັບ...'),
          duration: Duration(seconds: 2),
        ),
      );
    });

    widget.onStepChanged(3);
  }
}
