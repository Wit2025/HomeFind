// import 'package:flutter/material.dart';
// import 'package:homefind/generated/l10n.dart';
// import 'package:homefind/widgets/Colors.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:intl/intl.dart';

// class AddPage extends StatefulWidget {
//   const AddPage({super.key});

//   @override
//   State<AddPage> createState() => _AddPageState();
// }

// class _AddPageState extends State<AddPage> {
//   final _primaryColor = AppColors.color1;
//   final _darkPrimaryColor = AppColors.color2;
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _brokerageController = TextEditingController();

//   // State variables
//   int _selectedCategoryIndex = 0;
//   String _selectedCategorybutton = "ເຮືອນ";
//   String? _selectedStatus = "ເຊົ່າ";
//   String? _selectedRoomSharing = "ບໍ່ແຊຫ້ອງ";
//   String? _selectedRentalPeriod = "ເປັນເດືອນ";
//   String? _selectedCurrency = "LAK";
//   File? _selectedMainImage;
//   List<File> _selectedPropertyImages = [];
//   bool _isLoading = false;
//   double _totalPrice = 0.0;
//   final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

//   // Amenities selection
//   final Map<String, bool> _amenities = {
//     'ຈອດລົດ': false,
//     'ອິນເຕີເນັດ': false,
//     'ເຄື່ອງເຮືອນ': false,
//     'ສະລອຍນໍ້າ': false,
//     'ຕູ້ເຢັນ': false,
//     'ກວດຄົນເຂົ້າ': false,
//     'ແອ': false,
//     'ເຄື່ອງຊັກຜ້າ': false,
//   };

//   // Categories data
//   final List<Map<String, dynamic>> categories = [
//     {'title': 'ເຮືອນ', 'icon': Icons.home},
//     {'title': 'ຫ້ອງແຖວ', 'icon': Icons.home_work},
//     {'title': 'ອາພາດເມັ້ນ', 'icon': Icons.apartment},
//     {'title': 'ດິນ', 'icon': Icons.landscape},
//     {'title': 'ແຊທີ່ພັກ', 'icon': Icons.castle},
//     {'title': 'ຕິດຕັ້ງແອ', 'icon': Icons.ac_unit},
//     {'title': 'ແກ່ເຄື່ອງ', 'icon': Icons.local_shipping},
//     {'title': 'ຕິດຕັ້ງແວ່ນ', 'icon': Icons.window},
//     {'title': 'ເຟີນີເຈີ້', 'icon': Icons.chair},
//   ];

//   // Translation helper methods
//   String _translateValue(String value) {
//     switch (value) {
//       case 'ເຊົ່າ':
//         return S.of(context).rent;
//       case 'ຂາຍ':
//         return S.of(context).sale;
//       case 'ເຮືອນ':
//         return S.of(context).house;
//       case 'ຫ້ອງແຖວ':
//         return S.of(context).townhouse;
//       case 'ອາພາດເມັ້ນ':
//         return S.of(context).apartment;
//       case 'ດິນ':
//         return S.of(context).land;
//       case 'ແຊທີ່ພັກ':
//         return S.of(context).room_sharing;
//       case 'ຕິດຕັ້ງແອ':
//         return S.of(context).install_air;
//       case 'ແກ່ເຄື່ອງ':
//         return S.of(context).moving_goods;
//       case 'ຕິດຕັ້ງແວ່ນ':
//         return S.of(context).install_glass;
//       case 'ເຟີນີເຈີ້':
//         return S.of(context).furniture;
//       case 'ແຊຫ້ອງ':
//         return S.of(context).share_room;
//       case 'ບໍ່ແຊຫ້ອງ':
//         return S.of(context).no_share_room;
//       case 'ເປັນເດືອນ':
//         return S.of(context).per_month;
//       case 'ເປັນປີ':
//         return S.of(context).perYear;
//       case 'ຈອດລົດ':
//         return S.of(context).parking;
//       case 'ອິນເຕີເນັດ':
//         return S.of(context).internet;
//       case 'ເຄື່ອງເຮືອນ':
//         return S.of(context).furniture;
//       case 'ສະລອຍນໍ້າ':
//         return S.of(context).swimmingPool;
//       case 'ຕູ້ເຢັນ':
//         return S.of(context).refrigerator;
//       case 'ກວດຄົນເຂົ້າ':
//         return S.of(context).security_check;
//       case 'ແອ':
//         return S.of(context).air;
//       case 'ເຄື່ອງຊັກຜ້າ':
//         return S.of(context).washing_machine;
//       default:
//         return value;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     _priceController.addListener(_calculateTotal);
//     _brokerageController.addListener(_calculateTotal);
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _priceController.dispose();
//     _locationController.dispose();
//     _descriptionController.dispose();
//     _phoneController.dispose();
//     _brokerageController.dispose();
//     _priceController.removeListener(_calculateTotal);
//     _brokerageController.removeListener(_calculateTotal);
//     super.dispose();
//   }

//   Future<void> _pickMainImage() async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 90,
//       );

//       if (pickedFile != null) {
//         setState(() {
//           _selectedMainImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${S.of(context).image_selection_error}: $e'),
//             backgroundColor: Color.fromARGB(255, 12, 105, 122),
//           ),
//         );
//       }
//     }
//   }

//   void _removeMainImage() {
//     setState(() {
//       _selectedMainImage = null;
//     });
//   }

//   Future<void> _pickPropertyImages() async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final List<XFile> pickedFiles = await picker.pickMultiImage(
//         maxWidth: 1200,
//         maxHeight: 1200,
//         imageQuality: 85,
//       );

//       if (pickedFiles.isNotEmpty) {
//         final int remainingSlots = 16 - _selectedPropertyImages.length;

//         if (remainingSlots <= 0) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(S.of(context).full_16_images),
//                 backgroundColor: Color.fromARGB(255, 12, 105, 122),
//               ),
//             );
//           }
//           return;
//         }

//         final List<File> newImages = pickedFiles
//             .take(remainingSlots)
//             .map((file) => File(file.path))
//             .toList();

//         setState(() {
//           _selectedPropertyImages.addAll(newImages);
//         });

//         if (pickedFiles.length > remainingSlots && mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(S.of(context).max_16_images),
//               backgroundColor: Color.fromARGB(255, 12, 105, 122),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${S.of(context).image_selection_error}: $e'),
//             backgroundColor: Color.fromARGB(255, 12, 105, 122),
//           ),
//         );
//       }
//     }
//   }

//   void _removePropertyImage(int index) {
//     setState(() {
//       _selectedPropertyImages.removeAt(index);
//     });
//   }

//   void _calculateTotal() {
//     final price = double.tryParse(_priceController.text) ?? 0.0;
//     final brokerage = double.tryParse(_brokerageController.text) ?? 0.0;

//     setState(() {
//       _totalPrice = price + brokerage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: ValueKey(Localizations.localeOf(context).languageCode),
//       backgroundColor: Colors.grey[50],
//       appBar: _buildAppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildWelcomeSection(),
//                     const SizedBox(height: 14),
//                     _buildCategorySection(),
//                     const SizedBox(height: 14),
//                     _buildMainImageSection(),
//                     const SizedBox(height: 14),
//                     _buildPropertyImagesSection(),
//                     const SizedBox(height: 14),
//                     _buildBasicInfoSection(),
//                     const SizedBox(height: 14),
//                     _buildDetailsSection(),
//                     const SizedBox(height: 14),
//                     _buildContactSection(),
//                     const SizedBox(height: 14),
//                     _buildDescriptionSection(),
//                     const SizedBox(height: 14),
//                     _buildAmenitiesSection(),
//                     const SizedBox(height: 40),
//                     _buildBottomNavigation(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       title: Text(
//         S.of(context).post_for_me,
//         style: TextStyle(
//           fontWeight: FontWeight.w600,
//           fontSize: 20,
//           color: Colors.white,
//         ),
//       ),
//       centerTitle: true,
//       elevation: 0,
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [_primaryColor, _darkPrimaryColor],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildWelcomeSection() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             _primaryColor.withOpacity(0.1),
//             _primaryColor.withOpacity(0.05),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: _primaryColor.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: _primaryColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(
//                   Icons.home_work_outlined,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   S.of(context).accommodation_info,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 12, 105, 122),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             S.of(context).complete_info_for_promo,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//               height: 1.4,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategorySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).service_type,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: _darkPrimaryColor,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Center(
//           child: Container(
//             height: 190,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 20,
//                   offset: Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 5,
//                   crossAxisSpacing: 0,
//                   mainAxisSpacing: 0,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: _buildCategoryButton(
//                       category['title'],
//                       category['icon'],
//                       _selectedCategoryIndex == index,
//                       index,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCategoryButton(
//     String title,
//     IconData icon,
//     bool isSelected,
//     int index,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedCategoryIndex = index;
//           _selectedCategorybutton = title; // Keep original Lao value
//         });
//       },
//       child: Semantics(
//         button: true,
//         selected: isSelected,
//         label: '${S.of(context).category} ${_translateValue(title)}',
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.teal.shade100 : Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(8),
//                 border: isSelected
//                     ? Border.all(color: Colors.teal.shade200, width: 1)
//                     : null,
//               ),
//               child: Icon(
//                 icon,
//                 color: isSelected ? Colors.teal : Colors.grey,
//                 size: 27,
//               ),
//             ),

//             const SizedBox(height: 6),

//             AnimatedDefaultTextStyle(
//               duration: const Duration(milliseconds: 200),
//               style: TextStyle(
//                 color: isSelected ? Colors.blue : Colors.grey,
//                 fontSize: 12,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//               child: Text(
//                 _translateValue(title), // Display translated text
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMainImageSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).upload_main_image,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 12, 105, 122),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Center(
//           child: GestureDetector(
//             onTap: _pickMainImage,
//             child: Container(
//               width: 280,
//               height: 180,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: _selectedMainImage != null
//                       ? _primaryColor
//                       : Colors.grey[300]!,
//                   width: 3,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 15,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: _selectedMainImage == null
//                   ? _buildEmptyMainImagePlaceholder()
//                   : _buildMainImageDisplay(),
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Center(
//           child: Text(
//             S.of(context).upload_current_photo_1,
//             style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmptyMainImagePlaceholder() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(Icons.image, size: 50, color: _primaryColor),
//         const SizedBox(height: 8),
//         Text(
//           S.of(context).tap_to_upload,
//           style: TextStyle(
//             color: _primaryColor,
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMainImageDisplay() {
//     return Stack(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: Image.file(_selectedMainImage!, fit: BoxFit.cover),
//           ),
//         ),
//         Positioned(
//           top: 5,
//           right: 5,
//           child: GestureDetector(
//             onTap: _removeMainImage,
//             child: Container(
//               height: 35,
//               width: 35,
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.close, color: Colors.white, size: 18),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPropertyImagesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).accommodation_photos,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 12, 105, 122),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           height: 150,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
//           child: _selectedPropertyImages.isEmpty
//               ? _buildEmptyPropertyImagePlaceholder()
//               : _buildPropertyImageList(),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: double.infinity,
//           child: OutlinedButton.icon(
//             onPressed: _pickPropertyImages,
//             style: OutlinedButton.styleFrom(
//               side: BorderSide(color: _primaryColor),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             icon: Icon(
//               Icons.add_photo_alternate_outlined,
//               color: _primaryColor,
//             ),
//             label: Text(
//               S.of(context).add_photo,
//               style: TextStyle(
//                 color: _primaryColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmptyPropertyImagePlaceholder() {
//     return GestureDetector(
//       onTap: _pickPropertyImages,
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: Colors.grey[300]!,
//             width: 2,
//             style: BorderStyle.solid,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.collections_outlined, size: 50, color: _primaryColor),
//             const SizedBox(height: 8),
//             Text(
//               S.of(context).upload_main_image,
//               style: TextStyle(
//                 color: _primaryColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               S.of(context).max_16_images,
//               style: TextStyle(color: Colors.grey[600], fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPropertyImageList() {
//     return SizedBox(
//       height: 150,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount:
//             _selectedPropertyImages.length +
//             (_selectedPropertyImages.length < 16 ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == _selectedPropertyImages.length) {
//             return GestureDetector(
//               onTap: _pickPropertyImages,
//               child: Container(
//                 width: 120,
//                 margin: const EdgeInsets.only(right: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: Colors.grey[300]!,
//                     width: 2,
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.add, size: 30, color: _primaryColor),
//                     const SizedBox(height: 4),
//                     Text(
//                       S.of(context).add_photo,
//                       style: TextStyle(color: _primaryColor, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           return Container(
//             width: 120,
//             margin: const EdgeInsets.only(right: 12),
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.file(
//                     _selectedPropertyImages[index],
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//                 Positioned(
//                   top: 5,
//                   right: 5,
//                   child: GestureDetector(
//                     onTap: () => _removePropertyImage(index),
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: const BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.close,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildBasicInfoSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).basic_info,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 12, 105, 122),
//           ),
//         ),
//         const SizedBox(height: 8),
//         _buildInputField(
//           label: S.of(context).accommodation_name,
//           controller: _titleController,
//           icon: Icons.title_outlined,
//           validator: (value) => value?.isEmpty ?? true
//               ? S.of(context).please_enter_accommodation_name
//               : null,
//         ),

//         const SizedBox(height: 8),
//         _buildTranslatableDropdownField(
//           S.of(context).status,
//           _selectedStatus,
//           ['ເຊົ່າ', 'ຂາຍ'],
//           (value) => setState(() {
//             _selectedStatus = value;
//             if (value != 'ເຊົ່າ') {
//               _selectedRentalPeriod = null;
//             } else {
//               _selectedRentalPeriod = 'ເປັນເດືອນ';
//             }
//           }),
//           Icons.sell_outlined,
//         ),
//         const SizedBox(height: 8),
//         if (_selectedStatus == 'ເຊົ່າ') ...[
//           _buildTranslatableDropdownField(
//             S.of(context).rental_period,
//             _selectedRentalPeriod,
//             ['ເປັນເດືອນ', 'ເປັນປີ'],
//             (value) => setState(() => _selectedRentalPeriod = value),
//             Icons.schedule_outlined,
//           ),
//           const SizedBox(height: 8),
//           _buildTranslatableDropdownField(
//             S.of(context).share_room,
//             _selectedRoomSharing,
//             ['ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
//             (value) => setState(() => _selectedRoomSharing = value),
//             Icons.people_outlined,
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildDetailsSection() {
//     String getPriceLabel() {
//       if (_selectedStatus == 'ເຊົ່າ') {
//         if (_selectedRentalPeriod == 'ເປັນປີ') {
//           return '${S.of(context).price_per_year} ${_selectedCurrency}';
//         } else {
//           return '${S.of(context).price_per_month} ${_selectedCurrency}';
//         }
//       } else {
//         return '${S.of(context).price} ${_selectedCurrency}';
//       }
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).price,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 12, 105, 122),
//           ),
//         ),
//         const SizedBox(height: 12),
//         _buildDropdownField(
//           S.of(context).selectCurrency,
//           _selectedCurrency,
//           ['LAK', 'THB', 'USD', 'CNY', 'KRW'],
//           (value) => setState(() => _selectedCurrency = value),
//           Icons.currency_exchange_outlined,
//         ),
//         const SizedBox(height: 8),
//         _buildInputField(
//           label: getPriceLabel(),
//           controller: _priceController,
//           icon: Icons.monetization_on_outlined,
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             if (value?.isEmpty ?? true) return S.of(context).please_enter_price;
//             if (double.tryParse(value!) == null)
//               return S.of(context).please_enter_correct_number;
//             return null;
//           },
//         ),
//         const SizedBox(height: 8),
//         _buildInputField(
//           label: S.of(context).commissionFee,
//           controller: _brokerageController,
//           icon: Icons.handshake,
//           keyboardType: TextInputType.number,
//         ),
//         _buildTotalPrice(),
//       ],
//     );
//   }

//   Widget _buildTotalPrice() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.only(top: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.calculate, color: Colors.green, size: 20),
//           const SizedBox(width: 8),
//           Text(
//             '${S.of(context).totalPrice}:',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[700],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const Spacer(),
//           Text(
//             '${currencyFormat.format(_totalPrice)} $_selectedCurrency',
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.green,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).addressAndContact,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 12, 105, 122),
//           ),
//         ),
//         const SizedBox(height: 12),
//         _buildInputField(
//           label: S.of(context).address,
//           controller: _locationController,
//           icon: Icons.location_on_outlined,
//           validator: (value) => value?.isEmpty ?? true
//               ? S.of(context).please_enter_address
//               : null,
//         ),
//         const SizedBox(height: 8),
//         _buildInputField(
//           label: S.of(context).phone,
//           hint: '20xxxxxxxx',
//           controller: _phoneController,
//           icon: Icons.phone_outlined,
//           keyboardType: TextInputType.phone,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return S.of(context).please_enter_phone;
//             }
//             if (!RegExp(r'^20[2579]\d{7}').hasMatch(value)) {
//               return S.of(context).invalid_phone_number;
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildDescriptionSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).additional_details,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 12, 105, 122),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: TextFormField(
//             controller: _descriptionController,
//             decoration: InputDecoration(
//               labelText: S.of(context).additional_details_optional,
//               hintText: S.of(context).description_placeholder,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: _primaryColor, width: 2),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//               alignLabelWithHint: true,
//               contentPadding: const EdgeInsets.all(20),
//             ),
//             maxLines: 5,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAmenitiesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).facilities,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 12, 105, 122),
//           ),
//         ),
//         const SizedBox(height: 12),
//         GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//             childAspectRatio: 3,
//           ),
//           itemCount: _amenities.length,
//           itemBuilder: (context, index) {
//             final amenity = _amenities.keys.elementAt(index);
//             final isSelected = _amenities[amenity]!;

//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _amenities[amenity] = !_amenities[amenity]!;
//                 });
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: isSelected ? _primaryColor : Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: isSelected ? _primaryColor : Colors.grey[300]!,
//                     width: 2,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       _getAmenityIcon(amenity),
//                       color: isSelected ? Colors.white : _primaryColor,
//                       size: 20,
//                     ),
//                     const SizedBox(width: 8),
//                     Flexible(
//                       child: Text(
//                         _translateValue(amenity), // Display translated amenity
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black87,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildInputField({
//     required String label,
//     String hint = "",
//     required TextEditingController controller,
//     required IconData icon,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: _primaryColor, width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           prefixIcon: Icon(icon, color: _primaryColor),
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 16,
//             horizontal: 20,
//           ),
//         ),
//         keyboardType: keyboardType,
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     String? value,
//     List<String> items,
//     void Function(String?) onChanged,
//     IconData icon,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: InputDecorator(
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           prefixIcon: Icon(icon, color: _primaryColor),
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 8,
//             horizontal: 20,
//           ),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             isExpanded: true,
//             icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
//             style: const TextStyle(color: Colors.black, fontSize: 16),
//             items: items.map((String item) {
//               return DropdownMenuItem<String>(value: item, child: Text(item));
//             }).toList(),
//             onChanged: onChanged,
//             dropdownColor: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }

//   // New method for translatable dropdown fields
//   Widget _buildTranslatableDropdownField(
//     String label,
//     String? value,
//     List<String> items,
//     void Function(String?) onChanged,
//     IconData icon,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: InputDecorator(
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey[300]!),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           prefixIcon: Icon(icon, color: _primaryColor),
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 8,
//             horizontal: 20,
//           ),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: value,
//             isExpanded: true,
//             icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
//             style: const TextStyle(color: Colors.black, fontSize: 16),
//             items: items.map((String item) {
//               return DropdownMenuItem<String>(
//                 value: item, // Keep original Lao value
//                 child: Text(_translateValue(item)), // Display translated text
//               );
//             }).toList(),
//             onChanged: onChanged,
//             dropdownColor: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNavigation() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SizedBox(
//         width: double.infinity,
//         height: 56,
//         child: ElevatedButton(
//           onPressed: _isLoading ? null : _submitForm,
//           style: ElevatedButton.styleFrom(
//             padding:
//                 EdgeInsets.zero, // ต้องเพิ่มบรรทัดนี้เพื่อให้ gradient เต็มปุ่ม
//             backgroundColor: Colors.transparent, // ตั้งค่าเป็น transparent
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 0,
//             shadowColor: Colors.transparent,
//           ),
//           child: Ink(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.color1, AppColors.color2],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//               child: _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.cloud_upload, color: Colors.white, size: 30),
//                         SizedBox(width: 12),
//                         Text(
//                           S.of(context).submit_data,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   IconData _getAmenityIcon(String amenity) {
//     switch (amenity) {
//       case 'ຈອດລົດ':
//         return Icons.local_parking_outlined;
//       case 'ອິນເຕີເນັດ':
//         return Icons.wifi;
//       case 'ເຄື່ອງເຮືອນ':
//         return Icons.chair_outlined;
//       case 'ສະລອຍນໍ້າ':
//         return Icons.pool_outlined;
//       case 'ຕູ້ເຢັນ':
//         return Icons.kitchen_outlined;
//       case 'ກວດຄົນເຂົ້າ':
//         return Icons.security_outlined;
//       case 'ແອ':
//         return Icons.ac_unit_outlined;
//       case 'ເຄື່ອງຊັກຜ້າ':
//         return Icons.local_laundry_service_outlined;
//       default:
//         return Icons.check_outlined;
//     }
//   }

//   Future<void> _submitForm() async {
//     if (!_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(S.of(context).pleaseEnterCompleteData),
//           backgroundColor: Color.fromARGB(255, 12, 105, 122),
//         ),
//       );
//       return;
//     }

//     if (_selectedMainImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(S.of(context).please_upload_main_image),
//           backgroundColor: Color.fromARGB(255, 12, 105, 122),
//         ),
//       );
//       return;
//     }

//     if (_selectedPropertyImages.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(S.of(context).please_add_min_1_photo),
//           backgroundColor: Color.fromARGB(255, 12, 105, 122),
//         ),
//       );
//       return;
//     }

//     if (_selectedStatus == 'ເຊົ່າ' && _selectedRentalPeriod == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(S.of(context).please_select_rental_period),
//           backgroundColor: Color.fromARGB(255, 12, 105, 122),
//         ),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       // Simulate network request
//       await Future.delayed(const Duration(seconds: 2));

//       if (mounted) {
//         _showSuccessDialog();
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('${S.of(context).error}: $e'),
//             backgroundColor: Color.fromARGB(255, 12, 105, 122),
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           padding: const EdgeInsets.all(30),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 const Color.fromARGB(255, 87, 167, 177),
//                 const Color.fromARGB(255, 12, 105, 122),
//               ],
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//             ),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.check, size: 40, color: Colors.green),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 S.of(context).submit_success,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 '${S.of(context).you_posted_data}${_translateValue(_selectedCategorybutton)}${S.of(context).submit_success}',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.white,
//                   height: 1.4,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: 170,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.green[600],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).popUntil((route) => route.isFirst);
//                   },
//                   child: Text(
//                     S.of(context).understood,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// property_details_page.dart (Refactored)
import 'package:flutter/material.dart';
import 'package:homefind/screens/add/widget/property_app_bar.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_amenities_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_basic_info_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_bottom_navigation.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_category_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_contact_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_description_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_details_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_controller.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_submit_service.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_image_service.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_images_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_main_image_section.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_welcome_section.dart';
import 'package:homefind/widgets/Colors.dart';

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
                      onSubmit: () => PropertyFormSubmitService.submitForm(
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
