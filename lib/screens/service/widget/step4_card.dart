import 'package:flutter/material.dart';
import 'package:homefind/screens/service/chat/chat_service.dart';
import 'package:homefind/screens/service/widget/service_type.dart';
import 'package:homefind/screens/service/techView/widget/technician_response.dart';
import 'package:homefind/widgets/colors.dart';
import 'package:intl/intl.dart';

class Step4Responses extends StatelessWidget {
  final List<TechnicianResponse> technicianResponses;
  final bool hasNewResponses;
  final double? offerPrice;
  final String? selectedService;
  final List<ServiceType> services;
  final Function() onResetForm;
  final Function(List<TechnicianResponse>, {bool hasNew})
  onTechnicianResponsesChanged;
  final Function(int) onStepChanged;

  const Step4Responses({
    super.key,
    required this.technicianResponses,
    required this.hasNewResponses,
    required this.offerPrice,
    required this.selectedService,
    required this.services,
    required this.onResetForm,
    required this.onTechnicianResponsesChanged,
    required this.onStepChanged,
  });

  String _formatNumber(double number) {
    final formatter = NumberFormat('#,###.00', 'en_US');
    return formatter.format(number.toInt());
  }

  void _acceptTechnicianAndRejectOthers(
    TechnicianResponse selectedResponse,
    BuildContext context,
  ) {
    final rejectedTechnicians = technicianResponses
        .where((tech) => tech.technicianName != selectedResponse.technicianName)
        .toList();

    if (rejectedTechnicians.isNotEmpty) {
      for (var tech in rejectedTechnicians) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ປະຕິເສດ ${tech.technicianName} ອັດຕະໂນມັດ'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }

    onTechnicianResponsesChanged([selectedResponse], hasNew: false);
  }

  Widget _buildTechnicianResponseCard(
    TechnicianResponse response,
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.color2,
                  ),
                  child: Center(
                    child: Text(
                      response.technicianName[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        response.technicianName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        response.status == 'accepted'
                            ? 'ຍອມຮັບໃນລາຄາ ${_formatNumber(offerPrice ?? 0)} ກີບ'
                            : 'ສະເໜີລາຄາ ${_formatNumber(response.counterPrice ?? 0)} ກີບ',
                        style: TextStyle(
                          color: response.status == 'accepted'
                              ? AppColors.color1
                              : Colors.orange,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Show the location (title + address) if provided by the requester
            if (response.location != null) ...[
              Text(
                'ທີ່ຢູ່: ${response.location!.title}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                response.location!.address,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
            ],

            Text(
              response.message,
              style: TextStyle(
                color: response.status == 'accepted'
                    ? AppColors.color1
                    : response.status == 'counter'
                    ? Colors.orange
                    : Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      final updatedResponses = List<TechnicianResponse>.from(
                        technicianResponses,
                      )..remove(response);
                      onTechnicianResponsesChanged(updatedResponses);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'ທ່ານໄດ້ປະຕິເສດການແຈ້ງເຕືອນຈາກ ${response.technicianName}',
                          ),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red, width: 2),
                    ),
                    child: const Text('ປະຕິເສດ'),
                  ),
                ),

                const SizedBox(width: 8),
                if (response.status == 'counter')
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate back to step 2 so the user can change their offer
                        onStepChanged(2);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.color1,
                        side: const BorderSide(
                          color: AppColors.color1,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('ສະເໜີໃໝ່'),
                    ),
                  ),

                if (response.status == 'counter') const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _acceptTechnicianAndRejectOthers(response, context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            serviceId: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            serviceName: response.technicianName,
                            serviceType: selectedService ?? 'other',
                            serviceIcon: services
                                .firstWhere(
                                  (s) => s.type == selectedService,
                                  orElse: () => services.last,
                                )
                                .icon,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.color1,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('ຮັບ'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7 - 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ຊ່າງຕອບກັບ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (hasNewResponses)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.color1.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'ໃໝ່',
                    style: TextStyle(
                      color: AppColors.color1,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          Expanded(
            child: technicianResponses.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: technicianResponses.length,
                    itemBuilder: (context, index) {
                      final response = technicianResponses[index];
                      return _buildTechnicianResponseCard(response, context);
                    },
                  )
                : const Center(
                    child: Text(
                      'ບໍ່ມີການຕອບກັບຈາກຊ່າງ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: InkWell(
              onTap: onResetForm,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.color1, AppColors.color2],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'ສ້າງຄຳຂໍໃໝ່',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
