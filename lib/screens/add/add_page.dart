
import 'package:flutter/material.dart';
import 'package:homefind/screens/add/widget/property_app_bar.dart';
import 'package:homefind/screens/add/widget/property_form_submit_service.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_amenities_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_basic_info_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_bottom_navigation.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_category_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_contact_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_description_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_details_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_controller.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_image_service.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_images_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_main_image_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_welcome_section.dart';
import 'package:homefind/widgets/colors.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _primaryColor = AppColors.color1;
  final _darkPrimaryColor = AppColors.color2;
  final _formKey = GlobalKey<FormState>();
  late PropertyFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PropertyFormController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      appBar: AddPageAppBar(
        primaryColor: _primaryColor,
        darkPrimaryColor: _darkPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PropertyWelcomeSection(primaryColor: _primaryColor),
                    const SizedBox(height: 14),
                    PropertyCategorySection(
                      selectedCategoryIndex: _controller.selectedCategoryIndex,
                      onCategorySelected: _controller.updateCategorySelection,
                    ),
                    const SizedBox(height: 14),
                    PropertyMainImageSection(
                      primaryColor: _primaryColor,
                      selectedMainImage: _controller.selectedMainImage,
                      onPickImage: () => PropertyImageService.pickMainImage(
                        context,
                        _controller,
                      ),
                      onRemoveImage: _controller.removeMainImage,
                    ),
                    const SizedBox(height: 14),
                    PropertyImagesSection(
                      primaryColor: _primaryColor,
                      selectedPropertyImages:
                          _controller.selectedPropertyImages,
                      onPickImages: () =>
                          PropertyImageService.pickPropertyImages(
                            context,
                            _controller,
                          ),
                      onRemoveImage: _controller.removePropertyImage,
                    ),
                    const SizedBox(height: 14),
                    PropertyBasicInfoSection(
                      primaryColor: _primaryColor,
                      titleController: _controller.titleController,
                      selectedStatus: _controller.selectedStatus,
                      selectedRentalPeriod: _controller.selectedRentalPeriod,
                      selectedRoomSharing: _controller.selectedRoomSharing,
                      onStatusChanged: _controller.updateStatus,
                      onRentalPeriodChanged: _controller.updateRentalPeriod,
                      onRoomSharingChanged: _controller.updateRoomSharing,
                    ),
                    const SizedBox(height: 14),
                    PropertyDetailsSection(
                      primaryColor: _primaryColor,
                      priceController: _controller.priceController,
                      brokerageController: _controller.brokerageController,
                      selectedStatus: _controller.selectedStatus,
                      selectedRentalPeriod: _controller.selectedRentalPeriod,
                      selectedCurrency: _controller.selectedCurrency,
                      totalPrice: _controller.totalPrice,
                      currencyFormat: _controller.currencyFormat,
                      onCurrencyChanged: _controller.updateCurrency,
                    ),
                    const SizedBox(height: 14),
                    PropertyContactSection(
                      primaryColor: _primaryColor,
                      locationController: _controller.locationController,
                      phoneController: _controller.phoneController,
                    ),
                    const SizedBox(height: 14),
                    PropertyDescriptionSection(
                      primaryColor: _primaryColor,
                      descriptionController: _controller.descriptionController,
                    ),
                    const SizedBox(height: 14),
                    PropertyAmenitiesSection(
                      primaryColor: _primaryColor,
                      amenities: _controller.amenities,
                      onAmenityChanged: _controller.updateAmenity,
                    ),
                    const SizedBox(height: 40),
                    PropertyBottomNavigation(
                      isLoading: _controller.isLoading,
                      onSubmit: () => AddFormSubmitService.submitForm(
                        context,
                        _formKey,
                        _controller,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
