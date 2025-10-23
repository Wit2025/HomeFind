import 'package:homefind/screens/service/widget/service_location.dart';

enum MediaType { image, video }

class MediaAttachment {
  final String path;
  final MediaType type;

  MediaAttachment({required this.path, required this.type});
}

enum PaymentMethod { cash, bankTransfer, online }

class ServiceRequestModel {
  final String id;
  final String serviceType;
  final double? offeredPrice;
  final String description;
  final ServiceLocation? location;
  final String requesterName;
  final String status;
  final DateTime timestamp;
  final List<MediaAttachment> attachments;

  ServiceRequestModel({
    String? id,
    required this.serviceType,
    this.offeredPrice,
    required this.description,
    this.location,
    required this.requesterName,
    required this.status,
    DateTime? timestamp,
    this.attachments = const [],
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
       timestamp = timestamp ?? DateTime.now();
}
