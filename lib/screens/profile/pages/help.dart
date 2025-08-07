import 'package:flutter/material.dart';

class HelpPages extends StatefulWidget {
  const HelpPages({super.key});

  @override
  State<HelpPages> createState() => _HelpPagesState();
}

class _HelpPagesState extends State<HelpPages> {
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
          'ຊ່ວຍເຫຼືອ',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: 24),

            // Help Categories
            _buildHelpCategory(
              title: 'ປະເພດຄຳຖາມທີ່ນິຍົມ',
              items: [
                _buildHelpItem(
                  icon: Icons.lock,
                  title: 'ປັນຫາການເຂົ້າລະບົບ',
                  subtitle: 'ລືມລະຫັດຜ່ານ ຫຼື ບັນຊີຖືກລັອກ',
                ),
                _buildHelpItem(
                  icon: Icons.account_circle,
                  title: 'ຈັດການບັນຊີ',
                  subtitle: 'ປ່ຽນຂໍ້ມູນສ່ວນຕົວ ຫຼື ລຶບບັນຊີ',
                ),
                _buildHelpItem(
                  icon: Icons.shopping_cart,
                  title: 'ຄຳສັ່ງຊື້ & ການຊຳລະເງິນ',
                  subtitle: 'ກວດສອບການຊື້ ຫຼື ຄືນເງິນ',
                ),
                _buildHelpItem(
                  icon: Icons.privacy_tip,
                  title: 'ຄວາມປອດໄພ & ຄວາມເປັນສ່ວນໂຕ',
                  subtitle: 'ກ່ຽວກັບນະໂຍບາຍຂໍ້ມູນ',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Contact Section
            _buildContactSection(),
            const SizedBox(height: 24),

            // FAQ Section
            _buildFaqSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'ຊອກຫາຄຳຖາມ...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildHelpCategory({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C697A),
            ),
          ),
        ),
        Column(
          children: items
              .map(
                (item) => Column(
                  children: [
                    item,
                    if (item != items.last) const SizedBox(height: 12),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // TODO: go to detail help page
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F7F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF00CEB0), size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'ຕ້ອງການຊ່ວຍເຫຼືອເພີ່ມເຕີມ?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C697A),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'ທີມງານສະຫນັບສະຫນູນຂອງພວກເຮົາພ້ອມຊ່ວຍເຫຼືອທ່ານ 24 ຊົ່ວໂມງ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: contact support
                  },
                  icon: const Icon(Icons.email, size: 20),
                  label: const Text('ສົ່ງອີເມວ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C697A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: call support
                  },
                  icon: const Icon(Icons.phone, size: 20),
                  label: const Text('ໂທຫາ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00CEB0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'ຄຳຖາມທີ່ຖາມເລື້ອຍໆ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C697A),
            ),
          ),
        ),
        _buildFaqItem(question: 'ຂ້ອຍຈະປ່ຽນລະຫັດຜ່ານໄດ້ແນວໃດ?'),
        _buildFaqItem(question: 'ຂ້ອຍຈະຍົກເລີກການສັ່ງຊື້ໄດ້ແນວໃດ?'),
        _buildFaqItem(question: 'ວິທີການຊຳລະເງິນມີຫຍັງແດ່?'),
        _buildFaqItem(question: 'ຈະຕິດຕໍ່ສະຫນັບສະຫນູນໄດ້ຈາກໃສ?'),
      ],
    );
  }

  Widget _buildFaqItem({required String question}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              'ຄຳຕອບຕົວຢ່າງສຳລັບຄຳຖາມນີ້. ທ່ານສາມາດຊອກຫາຂໍ້ມູນເພີ່ມເຕີມໃນສ່ວນຊ່ວຍເຫຼືອຂອງແອັບພລິເຄຊັນຂອງພວກເຮົາ.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
