import 'package:flutter/material.dart';

class PrivacyPages extends StatefulWidget {
  const PrivacyPages({super.key});

  @override
  State<PrivacyPages> createState() => _PrivacyPagesState();
}

class _PrivacyPagesState extends State<PrivacyPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ຂໍ້ກໍານົດ ແລະ ນະໂຍບາຍ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF57A7B1), Color(0xFF0C697A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildPolicyItem(
              number: 1,
              title: 'ການເກັບຮັກຂໍ້ມູນ',
              content:
                  'ແອັບພລິເຄຊັນຈະເກັບຂໍ້ມູນສ່ວນຕົວເທົ່າທີ່ຈໍາເປັນ ເພື່ອປະສົງການໃຊ້ງານແລະການບໍລິການ.',
            ),
            _buildPolicyItem(
              number: 2,
              title: 'ການນໍາໃຊ້ຂໍ້ມູນ',
              content:
                  'ຂໍ້ມູນທີ່ໄດ້ຖືກເກັບຈະຖືກນໍາໃຊ້ໃນການພັດທະນາແລະປັບປຸງບໍລິການ.',
            ),
            _buildPolicyItem(
              number: 3,
              title: 'ການແບ່ງປັນຂໍ້ມູນ',
              content:
                  'ຂໍ້ມູນຂອງທ່ານຈະບໍ່ຖືກແບ່ງປັນໃຫ້ຜູ້ອື່ນ ນອກຈາກໃນກໍລະນີທີ່ມີກົດໝາຍກໍານົດ.',
            ),
            _buildPolicyItem(
              number: 4,
              title: 'ການປ້ອງກັນຂໍ້ມູນ',
              content:
                  'ແອັບພລິເຄຊັນໄດ້ດໍາເນີນມາດຕະການຄວາມປອດໄພເພື່ອປົກປ້ອງຂໍ້ມູນສ່ວນຕົວຂອງທ່ານ.',
            ),
            _buildPolicyItem(
              number: 5,
              title: 'ການປັບປຸງຂໍ້ກໍານົດ',
              content:
                  'ເຮົາອາດປັບປຸງນະໂຍບາຍນີ້ໃນອະນາຄົດ ກະລຸນາກວດເບິ່ງໃຫ້ທັນສະໄໝ.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ກະລຸນາອ່ານນະໂຍບາຍຄວາມເປັນສ່ວນຕົວຂອງພວກເຮົາຢ່າງລະອຽດກ່ອນການໃຊ້ງານແອັບພລິເຄຊັນ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyItem({
    required int number,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF0C697A),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C697A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
