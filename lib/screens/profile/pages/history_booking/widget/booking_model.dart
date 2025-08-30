class BookingModel {
  final String id;
  final String title;
  final String date;
  final String location;
  final String image;
  final String price;
  final String status;
  final String type;

  BookingModel({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.image,
    required this.price,
    required this.status,
    required this.type,
  });

  factory BookingModel.fromMap(Map<String, String> map) {
    return BookingModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      location: map['location'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? '',
      status: map['status'] ?? '',
      type: map['type'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'location': location,
      'image': image,
      'price': price,
      'status': status,
      'type': type,
    };
  }
}