import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

class HelpPages extends StatefulWidget {
  const HelpPages({super.key});

  @override
  State<HelpPages> createState() => _HelpPagesState();
}

class _HelpPagesState extends State<HelpPages> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Help items data
  List<HelpItem> _helpItems = [];
  List<FaqItem> _faqItems = [];
  bool _dataInitialized = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dataInitialized) {
      _initializeHelpItems();
      _dataInitialized = true;
    }
  }

  void _initializeHelpItems() {
    _helpItems = [
      HelpItem(
        icon: Icons.lock,
        title: S.of(context).loginIssues,
        subtitle: S.of(context).forgotPasswordOrLocked,
      ),
      HelpItem(
        icon: Icons.account_circle,
        title: S.of(context).accountManagement,
        subtitle: S.of(context).updatePersonalInfoOrDeleteAccount,
      ),
      HelpItem(
        icon: Icons.shopping_cart,
        title: S.of(context).ordersAndPayments,
        subtitle: S.of(context).purchaseOrRefundCheck,
      ),
      HelpItem(
        icon: Icons.privacy_tip,
        title: S.of(context).securityAndPrivacy,
        subtitle: S.of(context).aboutPolicy,
      ),
    ];

    _faqItems = [
      FaqItem(question: S.of(context).howToChangePassword),
      FaqItem(question: S.of(context).howToCancelOrder),
      FaqItem(question: S.of(context).paymentMethods),
      FaqItem(question: S.of(context).contactSupportFrom),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<HelpItem> get _filteredHelpItems {
    if (!_dataInitialized || _searchQuery.isEmpty) return _helpItems;
    return _helpItems.where((item) {
      return item.title.toLowerCase().contains(_searchQuery) ||
          item.subtitle.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  List<FaqItem> get _filteredFaqItems {
    if (!_dataInitialized || _searchQuery.isEmpty) return _faqItems;
    return _faqItems.where((item) {
      return item.question.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  bool get _hasResults {
    return _filteredHelpItems.isNotEmpty || _filteredFaqItems.isNotEmpty;
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
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar - Fixed at top
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey[50],
            child: _buildSearchBar(),
          ),

          // Results
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildAllContent()
                : _buildSearchResults(),
          ),
        ],
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
        controller: _searchController,
        decoration: InputDecoration(
          hintText: S.of(context).searchQuestions,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500]),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
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

  Widget _buildAllContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Help Categories
          _buildHelpCategory(
            title: S.of(context).popularQuestionTypes,
            items: _helpItems
                .map(
                  (item) => _buildHelpItem(
                    icon: item.icon,
                    title: item.title,
                    subtitle: item.subtitle,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),

          // Contact Section
          _buildContactSection(),
          const SizedBox(height: 24),

          // FAQ Section
          _buildFaqSection(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (!_hasResults) {
      return _buildNoResults();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Results Header
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              // 'ผลการค้นหาสำหรับ "$_searchQuery"',
              S.of(context).searchResultsFor(_searchQuery),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),

          // Filtered Help Items
          if (_filteredHelpItems.isNotEmpty) ...[
            _buildHelpCategory(
              // title: 'หมวดหมู่ความช่วยเหลือ (${_filteredHelpItems.length})',
              title: S
                  .of(context)
                  .helpCategoriesCount(_filteredHelpItems.length),
              items: _filteredHelpItems
                  .map(
                    (item) => _buildHelpItem(
                      icon: item.icon,
                      title: item.title,
                      subtitle: item.subtitle,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Filtered FAQ Items
          if (_filteredFaqItems.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(left: 8, bottom: 12),
              child: Text(
                // 'คำถามที่พบบ่อย (${_filteredFaqItems.length})',
                S.of(context).frequentQuestionsCount(_filteredFaqItems.length),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C697A),
                ),
              ),
            ),
            ..._filteredFaqItems.map(
              (item) => _buildFaqItem(question: item.question),
            ),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              // 'ไม่พบผลการค้นหา',
              S.of(context).noSearchResults,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              // 'ลองค้นหาด้วยคำอื่น หรือติดต่อทีมสนับสนุน',
              S.of(context).tryOtherKeywords,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _searchController.clear();
              },
              icon: const Icon(Icons.refresh),
              // label: const Text('เคลียร์การค้นหา'),
              label: Text(S.of(context).clearSearch),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C697A),
                foregroundColor: Colors.white,
              ),
            ),
          ],
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
                child: Icon(icon, color: AppColors.color1, size: 24),
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
                    backgroundColor: AppColors.color2,
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
                    backgroundColor: AppColors.color1,
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
        ..._faqItems.map((item) => _buildFaqItem(question: item.question)),
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

// Helper classes for data structure
class HelpItem {
  final IconData icon;
  final String title;
  final String subtitle;

  HelpItem({required this.icon, required this.title, required this.subtitle});
}

class FaqItem {
  final String question;

  FaqItem({required this.question});
}
