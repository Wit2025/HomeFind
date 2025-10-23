import 'package:flutter/material.dart';
import 'package:homefind/screens/service/widget/service_type.dart';
import 'package:homefind/widgets/colors.dart';
import 'package:homefind/screens/service/widget/service_location.dart';

class Step1LocationService extends StatefulWidget {
  final String? selectedService;
  final List<ServiceType> services;
  final ServiceLocation? selectedLocation;
  final List<ServiceLocation> locations;
  final double? initialPrice;
  final Function(String?) onServiceChanged;
  final Function(ServiceLocation?) onLocationChanged;
  final Function(double?) onPriceChanged;
  final Function() onNextStep;

  const Step1LocationService({
    super.key,
    required this.selectedService,
    required this.services,
    required this.selectedLocation,
    required this.locations,
    this.initialPrice,
    required this.onServiceChanged,
    required this.onLocationChanged,
    required this.onPriceChanged,
    required this.onNextStep,
  });

  @override
  State<Step1LocationService> createState() => _Step1LocationServiceState();
}

class _Step1LocationServiceState extends State<Step1LocationService> {
  late TextEditingController _searchController;
  late List<ServiceLocation> _filteredLocations;
  String? _localSelectedLocationId;
  late TextEditingController _priceController;
  double? _editingPrice;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _priceController = TextEditingController();
    _filteredLocations = List.from(widget.locations);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(covariant Step1LocationService oldWidget) {
    super.didUpdateWidget(oldWidget);
    // sync local selection and editing price if parent changed the selectedLocation
    if (widget.selectedLocation?.id != oldWidget.selectedLocation?.id) {
      _localSelectedLocationId = widget.selectedLocation?.id;
      _editingPrice =
          widget.initialPrice ?? widget.selectedLocation?.suggestedPrice ?? 0.0;
      _priceController.text = _editingPrice != null
          ? _editingPrice!.toStringAsFixed(0)
          : '';
    }
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
    _priceController.dispose();
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3),
            const Text(
              'ຕຳແໜ່ງທີ່ຕ້ອງການໃຫ້ຊ່າງມາສ້ອມ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 5),

            const Text(
              'ປະເພດບໍລິການ',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 50,
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
                            size: 20,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                          const SizedBox(height: 2),
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
                    color: Colors.black.withValues(alpha: 0.05),
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
                                color: AppColors.color1.withValues(alpha: 0.12),
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
                          // initialize editable price with suggested or 0
                          _editingPrice = loc.suggestedPrice ?? 0.0;
                          _priceController.text = _editingPrice != null
                              ? _editingPrice!.toStringAsFixed(0)
                              : '';
                        });
                        widget.onLocationChanged(loc);
                        // notify parent of initial selected price
                        widget.onPriceChanged(_editingPrice);
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
                                    ? Colors.white.withValues(alpha: 0.12)
                                    : AppColors.color1.withValues(alpha: 0.08),
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
                                  // show editable price when this tile is selected
                                  if (isSelected)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _editingPrice =
                                                    (_editingPrice ?? 0) - 1000;
                                                if (_editingPrice! < 0) {
                                                  _editingPrice = 0;
                                                }
                                                _priceController.text =
                                                    _editingPrice!
                                                        .toStringAsFixed(0);
                                              });
                                              widget.onPriceChanged(
                                                _editingPrice,
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: 90,
                                            child: TextField(
                                              controller: _priceController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 6,
                                                    ),
                                                border: OutlineInputBorder(),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              onSubmitted: (v) {
                                                final parsed = double.tryParse(
                                                  v.replaceAll(',', ''),
                                                );
                                                setState(() {
                                                  _editingPrice = parsed ?? 0.0;
                                                  _priceController.text =
                                                      _editingPrice!
                                                          .toStringAsFixed(0);
                                                });
                                                widget.onPriceChanged(
                                                  _editingPrice,
                                                );
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _editingPrice =
                                                    (_editingPrice ?? 0) + 1000;
                                                _priceController.text =
                                                    _editingPrice!
                                                        .toStringAsFixed(0);
                                              });
                                              widget.onPriceChanged(
                                                _editingPrice,
                                              );
                                            },
                                          ),
                                        ],
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

            // Suggested price bar (appears when service + location selected)
            if (widget.selectedService != null &&
                widget.selectedLocation != null) ...[
              _SuggestedPriceBar(
                serviceType: widget.selectedService!,
                locationId: widget.selectedLocation!.id,
                onPriceChanged: widget.onPriceChanged,
              ),
              const SizedBox(height: 12),
            ],

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

class _SuggestedPriceBar extends StatefulWidget {
  final String serviceType;
  final String locationId;
  final ValueChanged<double?> onPriceChanged;

  const _SuggestedPriceBar({
    required this.serviceType,
    required this.locationId,
    required this.onPriceChanged,
  });

  @override
  State<_SuggestedPriceBar> createState() => _SuggestedPriceBarState();
}

class _SuggestedPriceBarState extends State<_SuggestedPriceBar> {
  double? _price;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _price != null ? _price!.toStringAsFixed(0) : '',
    );
    // Do not auto-invoke onPriceChanged with a null/empty value here; the
    // parent will be notified when the user selects a location or edits the price.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
