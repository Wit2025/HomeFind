import 'package:homefind/screens/service/widget/service_location.dart';

class TechnicianResponse {
  final String technicianName;
  final String status;
  final double? counterPrice;
  final String message;
  final ServiceLocation? location;

  TechnicianResponse({
    required this.technicianName,
    required this.status,
    this.counterPrice,
    required this.message,
    this.location,
  });
}
