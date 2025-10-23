import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction.dart';
import 'package:homefind/screens/profile/pages/history_transection/widget/transaction_untils.dart';
import 'package:homefind/widgets/colors.dart';
import 'custom_painters.dart';

class TransactionDetailDialog extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailDialog({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [_buildTransactionIcon(), _buildContent(context)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.color1, AppColors.color2],
        ),
        borderRadius: BorderRadius.zero,
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(child: CustomPaint(painter: DotPatternPainter())),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Title in center
                Text(
                  S.of(context).withdrawalDetails,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                // Close button on the right
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionIcon() {
    return Transform.translate(
      offset: const Offset(0, -35),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.color1, AppColors.color1.withValues(alpha: 0.8)],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.color1.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.account_balance, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          // Amount Section
          _buildAmountSection(context),
          const SizedBox(height: 32),

          // Details Section
          _buildDetailsSection(context),
          const SizedBox(height: 32),

          // Close button
          _buildCloseButton(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildAmountSection(BuildContext context) {
    return Column(
      children: [
        Text(
          '- ₭ ${transaction.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C697A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: TransactionUtils.getStatusColor(
              transaction.status,
            ).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: TransactionUtils.getStatusColor(
                transaction.status,
              ).withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: TransactionUtils.getStatusColor(
                  transaction.status,
                ).withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            TransactionUtils.getStatusDisplayText(transaction.status, context),
            style: TextStyle(
              color: TransactionUtils.getStatusColor(transaction.status),
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            S.of(context).withdrawMethod,
            TransactionUtils.getMethodDisplayText(transaction.method, context),
          ),
          _buildDetailRow(
            S.of(context).destinationAccount,
            transaction.account,
          ),
          _buildDetailRow(
            S.of(context).fee,
            '₭ ${transaction.fee.toStringAsFixed(2)}',
          ),
          _buildDetailRow(S.of(context).transactionId, transaction.id),
          _buildDetailRow(S.of(context).date, transaction.date, isLast: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.color1.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                S.of(context).close,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
