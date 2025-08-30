import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/join_page/widget/conditions_page.dart';
import 'package:homefind/widgets/loading.dart';
import 'package:homefind/screens/join/join_page/widget/option_card.dart';
import 'package:homefind/screens/join/pages/personal_info_page/persional_info_page.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/property_details_page.dart';
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
  final Color _secondaryColor = AppColors.color2;
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
                    OptionCard(
                      title: S.of(context).post_own,
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
                    OptionCard(
                      title: S.of(context).post_for_me,
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
          : LoadingWidget(
              primaryColor: _primaryColor,
              loadingText: S.of(context).downloading,
            ),
    );
  }
}
