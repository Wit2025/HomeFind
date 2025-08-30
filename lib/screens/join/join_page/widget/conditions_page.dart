import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

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
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
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
                colors: [widget.primaryColor, widget.secondaryColor],
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
