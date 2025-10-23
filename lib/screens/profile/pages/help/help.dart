import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/help/widget/faq_item_widget.dart';
import 'package:homefind/screens/profile/pages/help/widget/help_category_widget.dart';
import 'package:homefind/screens/profile/pages/help/widget/help_contact_section.dart';
import 'package:homefind/screens/profile/pages/help/widget/help_item_widget.dart';
import 'package:homefind/screens/profile/pages/help/widget/help_models.dart';
import 'package:homefind/screens/profile/pages/help/widget/help_no_rsult_widget.dart';
import 'package:homefind/screens/profile/pages/help/widget/help_search_bar.dart';
import 'package:homefind/widgets/colors.dart';

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
          HelpSearchBar(
            searchController: _searchController,
            searchQuery: _searchQuery,
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

  Widget _buildAllContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Help Categories
          HelpCategoryWidget(
            title: S.of(context).popularQuestionTypes,
            items: _helpItems
                .map(
                  (item) => HelpItemWidget(
                    icon: item.icon,
                    title: item.title,
                    subtitle: item.subtitle,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),

          // Contact Section
          const HelpContactSection(),
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
      return HelpNoResultsWidget(
        onClearSearch: () {
          _searchController.clear();
        },
      );
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
            HelpCategoryWidget(
              title: S
                  .of(context)
                  .helpCategoriesCount(_filteredHelpItems.length),
              items: _filteredHelpItems
                  .map(
                    (item) => HelpItemWidget(
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
                S.of(context).frequentQuestionsCount(_filteredFaqItems.length),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C697A),
                ),
              ),
            ),
            ..._filteredFaqItems.map(
              (item) => FaqItemWidget(question: item.question),
            ),
          ],

          const SizedBox(height: 24),
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
        ..._faqItems.map((item) => FaqItemWidget(question: item.question)),
      ],
    );
  }
}
