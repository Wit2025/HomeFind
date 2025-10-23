import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_transection/history_transaction.dart';
import 'package:homefind/screens/profile/pages/point/point.dart';
import 'package:homefind/screens/profile/pages/withdraw/withdraw.dart';
import 'package:homefind/widgets/colors.dart';

class IncomeExpenseCard extends StatelessWidget {
  const IncomeExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIncomeExpenseItem(
                context,
                Icons.arrow_upward,
                S.of(context).income,
                '₭ 3,214',
                Colors.green,
              ),
              const SizedBox(width: 10),
              Container(
                width: 5,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
              const SizedBox(width: 10),
              _buildFeeItem(
                context,
                Icons.arrow_downward,
                S.of(context).fee,
                '₭ 1,550',
                Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context: context,
                  icon: Icons.download,
                  label: S.of(context).withdraw,
                  backgroundColor: const Color.fromARGB(61, 158, 158, 158),
                  iconColor: AppColors.color1,
                  labelColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WithdrawPages()),
                    );
                  },
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.emoji_events,
                  label: S.of(context).points,
                  backgroundColor: const Color.fromARGB(61, 158, 158, 158),
                  iconColor: AppColors.color1,
                  labelColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PointPages()),
                    );
                  },
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.history,
                  label: S.of(context).withdrawHistory,
                  backgroundColor: const Color.fromARGB(61, 158, 158, 158),
                  iconColor: AppColors.color1,
                  labelColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryTransaction(),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.mobile_screen_share,
                  label: S.of(context).inviteFriends,
                  backgroundColor: const Color.fromARGB(61, 158, 158, 158),
                  iconColor: AppColors.color1,
                  labelColor: Colors.black,
                  onTap: () {
                    // Add invite friends functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseItem(
    BuildContext context,
    IconData icon,
    String title,
    String amount,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeeItem(
    BuildContext context,
    IconData icon,
    String title,
    String amount,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color iconColor,
    required Color labelColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
