import 'package:flutter/material.dart';
import 'package:homefind/screens/service/widget/serviceType.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:homefind/screens/service/widget/service_location.dart';

class Step1LocationService extends StatefulWidget {
  final String? selectedService;
  final List<ServiceType> services;
  final ServiceLocation? selectedLocation;
  final List<ServiceLocation> locations;
  final Function(String?) onServiceChanged;
  final Function(ServiceLocation?) onLocationChanged;
  final Function() onNextStep;

  const Step1LocationService({
    Key? key,
    required this.selectedService,
    required this.services,
    required this.selectedLocation,
    required this.locations,
    required this.onServiceChanged,
    required this.onLocationChanged,
    required this.onNextStep,
  }) : super(key: key);

  @override
  State<Step1LocationService> createState() => _Step1LocationServiceState();
}

class _Step1LocationServiceState extends State<Step1LocationService> {
  late TextEditingController _searchController;
  late List<ServiceLocation> _filteredLocations;
  String? _localSelectedLocationId;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredLocations = List.from(widget.locations);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      _filteredLocations = widget.locations
          .where(
            (l) =>
                l.title.toLowerCase().contains(q) ||
                l.address.toLowerCase().contains(q),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7 - 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ເລືອກປະເພດບໍລິການ ແລະ ຈຸດທີ່ຢູ່ຂອງທີ່ໃຫ້ສ້ອມແປງ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ຕຳແໜ່ງທີ່ຕ້ອງການໃຫ້ຊ່າງມາສ້ອມ',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            const Text(
              'ປະເພດບໍລິການ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.services.length,
                itemBuilder: (context, index) {
                  final service = widget.services[index];
                  final isSelected = widget.selectedService == service.type;

                  return GestureDetector(
                    onTap: () => widget.onServiceChanged(service.type),
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.color1 : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.color1
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            service.icon,
                            size: 32,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[700],
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Location search bar (styled) - tap outside will unfocus keyboard
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                cursorColor: AppColors.color1,
                decoration: InputDecoration(
                  hintText: 'ຄົ້ນຫາຕຳແໜ່ງ...',
                  prefixIcon: Icon(Icons.search, color: AppColors.color1),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _onSearchChanged();
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // List of locations
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredLocations.length,
                itemBuilder: (context, index) {
                  final loc = _filteredLocations[index];
                  // consider local selection first so UI updates immediately
                  final selectedId =
                      _localSelectedLocationId ?? widget.selectedLocation?.id;
                  final isSelected = selectedId == loc.id;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppColors.color1, AppColors.color2],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: isSelected ? null : Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.color1
                            : Colors.grey[200]!,
                        width: 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.color1.withOpacity(0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          _localSelectedLocationId = loc.id;
                        });
                        widget.onLocationChanged(loc);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withOpacity(0.12)
                                    : AppColors.color1.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.color1,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loc.title,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    loc.address,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white70
                                          : Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: InkWell(
                onTap:
                    (widget.selectedService != null &&
                        widget.selectedLocation != null)
                    ? widget.onNextStep
                    : null,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient:
                        (widget.selectedService != null &&
                            widget.selectedLocation != null)
                        ? const LinearGradient(
                            colors: [AppColors.color1, AppColors.color2],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : const LinearGradient(
                            colors: [Colors.grey, Colors.grey],
                          ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'ຖັດໄປ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
