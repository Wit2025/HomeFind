// property_form_controller.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class PropertyFormController extends ChangeNotifier {
  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController brokerageController = TextEditingController();

  // State variables
  int selectedCategoryIndex = 0;
  String selectedCategoryButton = "ເຮືອນ";
  String? selectedStatus = "ເຊົ່າ";
  String? selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
  String? selectedRentalPeriod = "ເປັນເດືອນ";
  String? selectedCurrency = "LAK";
  File? selectedMainImage;
  List<File> selectedPropertyImages = [];
  bool isLoading = false;
  double totalPrice = 0.0;
  final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

  // Amenities selection
  final Map<String, bool> amenities = {
    'ຈອດລົດ': false,
    'ອິນເຕີເນັດ': false,
    'ເຄື່ອງເຮືອນ': false,
    'ສະລອຍນໍ້າ': false,
    'ຕູ້ເຢັນ': false,
    'ກວດຄົນເຂົ້າ': false,
    'ແອ': false,
    'ເຄື່ອງຊັກຜ້າ': false,
  };

  PropertyFormController() {
    priceController.addListener(calculateTotal);
    brokerageController.addListener(calculateTotal);
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    brokerageController.dispose();
    priceController.removeListener(calculateTotal);
    brokerageController.removeListener(calculateTotal);
    super.dispose();
  }

  void calculateTotal() {
    final price = double.tryParse(priceController.text) ?? 0.0;
    final brokerage = double.tryParse(brokerageController.text) ?? 0.0;
    totalPrice = price + brokerage;
    notifyListeners();
  }

  void updateCategorySelection(int index, String category) {
    selectedCategoryIndex = index;
    selectedCategoryButton = category;
    notifyListeners();
  }

  void updateStatus(String? value) {
    selectedStatus = value;
    if (value != 'ເຊົ່າ') {
      selectedRentalPeriod = null;
    } else {
      selectedRentalPeriod = 'ເປັນເດືອນ';
    }
    notifyListeners();
  }

  void updateRentalPeriod(String? value) {
    selectedRentalPeriod = value;
    notifyListeners();
  }

  void updateRoomSharing(String? value) {
    selectedRoomSharing = value;
    notifyListeners();
  }

  void updateCurrency(String? value) {
    selectedCurrency = value;
    notifyListeners();
  }

  void updateAmenity(String amenity, bool value) {
    amenities[amenity] = value;
    notifyListeners();
  }

  void setMainImage(File? image) {
    selectedMainImage = image;
    notifyListeners();
  }

  void removeMainImage() {
    selectedMainImage = null;
    notifyListeners();
  }

  void addPropertyImages(List<File> images) {
    selectedPropertyImages.addAll(images);
    notifyListeners();
  }

  void removePropertyImage(int index) {
    selectedPropertyImages.removeAt(index);
    notifyListeners();
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}
