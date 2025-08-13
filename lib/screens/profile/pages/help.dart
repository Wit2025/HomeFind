import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class HelpPages extends StatefulWidget {
  const HelpPages({super.key});

  @override
  State<HelpPages> createState() => _HelpPagesState();
}

class _HelpPagesState extends State<HelpPages> {
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
          S.of(context).help,
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
              title: S.of(context).popularQuestionTypes,
              items: [
                _buildHelpItem(
                  icon: Icons.lock,
                  title: S.of(context).loginIssues,
                  subtitle: S.of(context).forgotPasswordOrLocked,
                ),
                _buildHelpItem(
                  icon: Icons.account_circle,
                  title: S.of(context).accountManagement,
                  subtitle: S.of(context).updatePersonalInfoOrDeleteAccount,
                ),
                _buildHelpItem(
                  icon: Icons.shopping_cart,
                  title: S.of(context).ordersAndPayments,
                  subtitle: S.of(context).purchaseOrRefundCheck,
                ),
                _buildHelpItem(
                  icon: Icons.privacy_tip,
                  title: S.of(context).securityAndPrivacy,
                  subtitle: S.of(context).aboutPolicy,
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
          hintText: S.of(context).searchQuestions,
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
          Text(
            S.of(context).needMoreHelp,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C697A),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            S.of(context).supportTeam24h,
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
                  label: Text(S.of(context).sendEmail),
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
                  label: Text(S.of(context).call),
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
        Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            S.of(context).frequentQuestions,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C697A),
            ),
          ),
        ),
        _buildFaqItem(question: S.of(context).howToChangePassword),
        _buildFaqItem(question: S.of(context).howToCancelOrder),
        _buildFaqItem(question: S.of(context).paymentMethods),
        _buildFaqItem(question: S.of(context).contactSupportFrom),
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
              S.of(context).exampleAnswer,
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
