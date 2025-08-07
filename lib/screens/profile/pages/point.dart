import 'package:flutter/material.dart';

class PointPages extends StatefulWidget {
  const PointPages({super.key});

  @override
  State<PointPages> createState() => _PointPagesState();
}

class _PointPagesState extends State<PointPages> {
  int totalPoints = 1200;
  List<Map<String, dynamic>> pointHistory = [
    {
      "date": "2025-07-30",
      "description": "ໄດ້ຈາກການເຊົາ ...",
      "points": 100,
      "icon": Icons.shopping_bag,
    },
    {
      "date": "2025-07-29",
      "description": "ແນະນຳເພື່ອນ",
      "points": 200,
      "icon": Icons.people,
    },
    {
      "date": "2025-07-28",
      "description": "ໄດ້ຈາກການເຊົາ ...",
      "points": 300,
      "icon": Icons.shopping_bag,
    },
    {
      "date": "2025-07-27",
      "description": "ໄດ້ຈາກການເຊົາ ...",
      "points": 600,
      "icon": Icons.shopping_bag,
    },
  ];

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
          'ຄະແນນ',
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
      body: Column(
        children: [
          // Points Summary Card
          _buildPointsSummaryCard(),
          const SizedBox(height: 16),

          // Points History Header
          _buildHistoryHeader(),
          const SizedBox(height: 8),

          // Points History List
          _buildPointsHistoryList(),
        ],
      ),
    );
  }

  Widget _buildPointsSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF57A7B1), Color(0xFF0C697A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'ຄະແນນສະສົມທັງໝົດ',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '$totalPoints',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPointsAction(
                icon: Icons.card_giftcard,
                label: 'ແລກຄະແນນ',
                onTap: () {
                  // TODO: Redeem points
                },
              ),
              _buildPointsAction(
                icon: Icons.info_outline,
                label: 'ລາຍລະອຽດ',
                onTap: () {
                  // TODO: Show points details
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointsAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.history, color: Color(0xFF006B8B), size: 24),
          const SizedBox(width: 8),
          const Text(
            'ປະຫວັດຄະແນນ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006B8B),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // TODO: Show all history
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF00CEB0),
              padding: EdgeInsets.zero,
            ),
            child: const Text(
              'ທັງໝົດ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsHistoryList() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: pointHistory.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey[200], indent: 72),
        itemBuilder: (context, index) {
          final item = pointHistory[index];
          return _buildHistoryItem(
            icon: item['icon'] as IconData,
            description: item['description'] as String,
            date: item['date'] as String,
            points: item['points'] as int,
          );
        },
      ),
    );
  }

  Widget _buildHistoryItem({
    required IconData icon,
    required String description,
    required String date,
    required int points,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // TODO: Show transaction details
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
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
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+$points',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00CEB0),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ຄະແນນ',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
