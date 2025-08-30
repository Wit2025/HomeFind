import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/point/widget/history_header.dart';
import 'package:homefind/screens/profile/pages/point/widget/history_item.dart';
import 'package:homefind/screens/profile/pages/point/widget/points_summary_card.dart';
import 'package:homefind/widgets/Colors.dart';

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

  /// ฟังก์ชัน refresh ทั้งหน้า
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // ตัวอย่าง: reverse list เพื่อ refresh state
      pointHistory = List.from(pointHistory.reversed);
      totalPoints += 50; // เปลี่ยนค่าเพื่อทดสอบ refresh
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context).score,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: AppColors.color1,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Points Summary Card
              PointsSummaryCard(
                totalPoints: totalPoints,
                onRedeem: () {
                  // TODO: redeem points
                },
                onDetails: () {
                  // TODO: show details
                },
              ),
              const SizedBox(height: 16),

              // History Header
              HistoryHeader(
                onShowAll: () {
                  // TODO: show all history
                },
              ),
              const SizedBox(height: 8),

              // Points History
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: pointHistory.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey[200], indent: 72),
                itemBuilder: (context, index) {
                  final item = pointHistory[index];
                  return HistoryItem(
                    icon: item['icon'],
                    description: item['description'],
                    date: item['date'],
                    points: item['points'],
                    onTap: () {
                      // TODO: show transaction details
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
