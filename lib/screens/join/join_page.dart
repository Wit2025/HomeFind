import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/persional_info_page.dart';
import 'package:homefind/screens/join/pages/property_details_page.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinPages extends StatefulWidget {
  final VoidCallback onGoToAddPage;

  const JoinPages({super.key, required this.onGoToAddPage});

  @override
  State<JoinPages> createState() => _JoinPagesState();
}

class _JoinPagesState extends State<JoinPages> {
  bool _termsAccepted = false;
  final Color _primaryColor = AppColors.color1;
  final Color _secondaryColor = const Color(0xFF57A7B1);
  final Color _accentColor = const Color(0xFF4DB6AC);
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _checkTermsAcceptance();
  }

  Future<void> _checkTermsAcceptance() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _termsAccepted = prefs.getBool('terms_accepted') ?? false;
    });

    if (!_termsAccepted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTermsAndConditionsPage();
      });
    } else {
      setState(() {
        _showContent = true;
      });
    }
  }

  void _showTermsAndConditionsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TermsAndConditionsPage(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          accentColor: _accentColor,
          onAccept: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('terms_accepted', true);
            setState(() {
              _termsAccepted = true;
              _showContent = true;
            });
          },
        ),
      ),
    );
  }

  Future<void> checkAndNavigate(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isFilled = prefs.getBool('isPersonalInfoFilled') ?? false;

    if (isFilled) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PropertyDetailsPage(personalData: {}),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PersonalInfoPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).join,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.color1, AppColors.color2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: _termsAccepted && _showContent
          ? AnimatedOpacity(
              opacity: _showContent ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Welcome message
                    Text(
                      S.of(context).choose,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    // Post Own Card
                    _buildOptionCard(
                      title: S.of(context).post_own,
                      // subtitle: 'Create your own property listing',
                      subtitle: S.of(context).create_own_listing,
                      icon: Icons.home_work_outlined,
                      gradient: LinearGradient(
                        colors: [AppColors.color1, AppColors.color2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => checkAndNavigate(context),
                      isPrimary: true,
                    ),
                    const SizedBox(height: 24),
                    // Post For Me Card
                    _buildOptionCard(
                      title: S.of(context).post_for_me,
                      // subtitle: 'Let us help you create a listing',
                      subtitle: S.of(context).help_create_listing,
                      icon: Icons.support_agent_outlined,
                      gradient: LinearGradient(
                        colors: [_secondaryColor, _accentColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      onTap: () => widget.onGoToAddPage(),
                      isPrimary: false,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _primaryColor,
                          ),
                          strokeWidth: 3,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          S.of(context).downloading,
                          style: TextStyle(
                            color: _primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return Hero(
      tag: title,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Icon with background
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Arrow indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // 'Get Started',
                        S.of(context).get_started,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  final VoidCallback onAccept;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  const TermsAndConditionsPage({
    super.key,
    required this.onAccept,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late ScrollController _scrollController;
  bool _scrolledToEnd = false;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent == 0) {
        setState(() {
          _scrolledToEnd = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_scrolledToEnd) {
        setState(() {
          _scrolledToEnd = true;
        });
      }
    } else {
      if (_scrolledToEnd) {
        setState(() {
          _scrolledToEnd = false;
        });
      }
    }
  }

  bool get _canAcceptButtonBeEnabled => _scrolledToEnd && _isChecked;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canAcceptButtonBeEnabled,
      onPopInvoked: (didPop) {
        if (didPop && !_canAcceptButtonBeEnabled) {}
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: ValueKey(Localizations.localeOf(context).languageCode),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).terms_and_policies,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.secondaryColor, widget.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Center(
                      child: Icon(
                        Icons.assignment_outlined,
                        size: 50,
                        color: widget.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        S.of(context).welcome_message,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).read_terms_carefully,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('1. ${S.of(context).definitions_title}'),
                    _buildSectionContent(
                      '1.1 ${S.of(context).platform_definition}',
                    ),
                    _buildSectionContent(
                      '1.2 ${S.of(context).user_definition}',
                    ),
                    _buildSectionContent(
                      '1.3 ${S.of(context).content_definition}',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle(
                      '2. ${S.of(context).acceptance_of_terms_title}',
                    ),
                    _buildSectionContent(
                      '2.1 ${S.of(context).acceptance_clause}',
                    ),
                    _buildSectionContent(
                      '2.2 ${S.of(context).disagreement_clause}',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle(
                      '3. ${S.of(context).platform_usage_title}',
                    ),
                    _buildSectionContent(
                      '3.1 ${S.of(context).age_requirement}',
                    ),
                    _buildSectionContent(
                      '3.2 ${S.of(context).prohibited_content}',
                    ),
                    _buildSectionContent(
                      '3.3 ${S.of(context).unauthorized_use}',
                    ),
                    _buildSectionContent(
                      '3.4 ${S.of(context).content_moderation}',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle(
                      '4. ${S.of(context).privacy_policy_title}',
                    ),
                    _buildSectionContent(
                      '4.1 ${S.of(context).privacy_importance}',
                    ),
                    _buildSectionContent('4.2 ${S.of(context).data_consent}'),
                    const SizedBox(height: 16),
                    _buildSectionTitle(
                      '5. ${S.of(context).intellectual_property_title}',
                    ),
                    _buildSectionContent(
                      '5.1 ${S.of(context).content_ownership}',
                    ),
                    _buildSectionContent(
                      '5.2 ${S.of(context).copying_prohibition}',
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle(
                      '6. ${S.of(context).liability_limitation_title}',
                    ),
                    _buildSectionContent('6.1 ${S.of(context).as_is_service}'),
                    _buildSectionContent('6.2 ${S.of(context).no_liability}'),
                    const SizedBox(height: 16),
                    _buildSectionTitle(
                      '7. ${S.of(context).terms_changes_title}',
                    ),
                    _buildSectionContent(
                      '7.1 ${S.of(context).modification_rights}',
                    ),
                    _buildSectionContent('7.2 ${S.of(context).continued_use}'),
                    const SizedBox(height: 16),
                    _buildSectionTitle(
                      '8. ${S.of(context).applicable_law_title}',
                    ),
                    _buildSectionContent('8.1 ${S.of(context).governing_law}'),
                    _buildSectionContent('8.2 ${S.of(context).jurisdiction}'),
                    const SizedBox(height: 16),
                    _buildSectionTitle('9. ${S.of(context).contact_us_title}'),
                    _buildSectionContent(
                      '9.1 ${S.of(context).contact_info} support@example.com',
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(S.of(context).additional_terms_title),
                    _buildSectionContent(S.of(context).additional_terms_notice),
                    const SizedBox(height: 16),
                    _buildSectionContent(S.of(context).thank_you_message),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        S.of(context).enjoy_platform,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      title: Text(
                        S.of(context).acceptance_checkbox,
                        style: const TextStyle(fontSize: 15),
                      ),
                      value: _isChecked,
                      onChanged: _scrolledToEnd
                          ? (bool? newValue) {
                              setState(() {
                                _isChecked = newValue ?? false;
                              });
                            }
                          : null,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: widget.primaryColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _canAcceptButtonBeEnabled
                    ? () {
                        widget.onAccept();
                        Navigator.of(context).pop();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canAcceptButtonBeEnabled
                      ? widget.primaryColor
                      : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline),
                    const SizedBox(width: 10),
                    Text(
                      S.of(context).accept_button,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: widget.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
    );
  }
}
