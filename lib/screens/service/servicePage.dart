import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homefind/screens/service/widget/roleToggle.dart';
import 'package:homefind/screens/service/widget/serviceRequestContent.dart';
import 'package:homefind/screens/service/widget/service_location.dart';
import 'package:homefind/screens/service/widget/serviceType.dart';
import 'package:homefind/screens/service/techView/widget/technicianResponse.dart';
import 'package:homefind/screens/service/techView/technician_view.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';

class ServiceRequestPage extends StatefulWidget {
  const ServiceRequestPage({Key? key}) : super(key: key);

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  int _currentStep = 1;
  bool _isTechnicianMode = false;
  String? _selectedService;
  double? _offerPrice;
  File? _selectedImage;
  String _description = '';

  final List<ServiceType> _services = ServiceType.defaultServices;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<TechnicianResponse> _technicianResponses = [];
  bool _hasNewResponses = false;
  ServiceLocation? _selectedLocation;
  final List<ServiceLocation> _locations = ServiceLocation.sampleLocations();
  // No sample requests — technician view should only show real submissions
  final List<ServiceRequestModel> _sampleRequests = const [];
  // stable preview id so the preview ServiceRequestModel isn't recreated with a new id
  String _previewId = 'preview-${DateTime.now().millisecondsSinceEpoch}';

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  void _updateSelectedService(String? service) {
    setState(() {
      _selectedService = service;
    });
  }

  void _updateOfferPrice(double? price) {
    setState(() {
      _offerPrice = price;
    });
  }

  void _updateSelectedImage(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  void _updateDescription(String description) {
    setState(() {
      _description = description;
    });
  }

  void _updateTechnicianResponses(
    List<TechnicianResponse> responses, {
    bool hasNew = false,
  }) {
    setState(() {
      _technicianResponses = responses;
      _hasNewResponses = hasNew;
    });
  }

  void _updateSelectedLocation(ServiceLocation? location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  void _resetForm() {
    setState(() {
      _currentStep = 1;
      _selectedService = null;
      _offerPrice = null;
      _selectedImage = null;
      _description = '';
      _priceController.clear();
      _descriptionController.clear();
      _technicianResponses = [];
      _hasNewResponses = false;
      // regenerate preview id when the form is reset so a new preview can be tracked
      _previewId = 'preview-${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // เนื้อหาหลัก
          _isTechnicianMode
              ? TechnicianView(
                  requests: [
                    ..._sampleRequests,
                    if (_selectedService != null)
                      ServiceRequestModel(
                        // Use a stable preview id (stored in state) so we can track tech actions
                        id: _previewId,
                        serviceType: _selectedService ?? 'other',
                        offeredPrice: _offerPrice,
                        description: _description,
                        // new submissions should start in pending/waiting state
                        status: 'pending',
                        location: _selectedLocation,
                        requesterName: 'Somesack',
                        imagePaths: _selectedImage != null
                            ? [_selectedImage!.path]
                            : const [],
                      ),
                  ],
                  onDecision: (requestId, decision, {counterPrice, description}) {
                    // If the technician declined, do NOT notify the user — just remove it from tech view
                    if (decision == 'declined') {
                      // nothing to add to user responses
                      return;
                    }

                    // For accepted or counter decisions, create a TechnicianResponse with explicit messages
                    final response = TechnicianResponse(
                      technicianName: 'Tech-${requestId.substring(0, 6)}',
                      status: decision == 'accepted' ? 'accepted' : 'counter',
                      counterPrice: counterPrice,
                      // If the technician provided a description for the counter,
                      // show it to the user; otherwise fall back to the default
                      // message per decision.
                      message: decision == 'accepted'
                          ? 'ຍອມຮັບ'
                          : (description != null && description.isNotEmpty)
                          ? description
                          : 'เสนอราคาใหม่แล้ว',
                      location: _selectedLocation,
                    );

                    setState(() {
                      _technicianResponses = [
                        response,
                        ..._technicianResponses,
                      ];
                      _hasNewResponses = true;
                    });
                  },
                )
              : ServiceRequestContent(
                  currentStep: _currentStep,
                  selectedService: _selectedService,
                  offerPrice: _offerPrice,
                  selectedImage: _selectedImage,
                  description: _description,
                  services: _services,
                  priceController: _priceController,
                  descriptionController: _descriptionController,
                  technicianResponses: _technicianResponses,
                  hasNewResponses: _hasNewResponses,
                  selectedLocation: _selectedLocation,
                  locations: _locations,
                  onLocationChanged: _updateSelectedLocation,
                  onStepChanged: _updateStep,
                  onServiceChanged: _updateSelectedService,
                  onPriceChanged: _updateOfferPrice,
                  onImageChanged: _updateSelectedImage,
                  onDescriptionChanged: _updateDescription,
                  onTechnicianResponsesChanged: _updateTechnicianResponses,
                  onResetForm: _resetForm,
                ),

          // ปุ่ม Toggle ทับบนเนื้อหา (มุมบนขวา)
          Positioned(
            top: MediaQuery.of(context).padding.top + (-30),
            right: 5,
            child: RoleToggle(
              isTechnicianMode: _isTechnicianMode,
              onChanged: (bool value) {
                setState(() {
                  _isTechnicianMode = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
