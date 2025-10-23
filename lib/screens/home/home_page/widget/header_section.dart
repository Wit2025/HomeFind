// widgets/header_section.dart
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

class HeaderSection extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool showHint;
  final bool isFocused;
  final VoidCallback onClearPressed;
  final VoidCallback onSearchPressed;

  const HeaderSection({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.showHint,
    required this.isFocused,
    required this.onClearPressed,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.color1, AppColors.color2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(26),
        child: Column(
          children: [
            _buildHeaderTitle(),
            SizedBox(height: 25),
            _buildSearchBar(),
            SizedBox(height: 25),
            _buildAnimatedSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Text(
      S.of(context).find_next_home,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                if (widget.showHint && !widget.isFocused)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IgnorePointer(
                      ignoring: true,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            S.of(context).search_name_address,
                            textStyle: TextStyle(color: Colors.grey),
                            speed: Duration(milliseconds: 100),
                            cursor: '',
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                    ),
                  ),
                TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                    contentPadding: EdgeInsets.only(
                      left: 12,
                      right:
                          (widget.isFocused ||
                              widget.controller.text.isNotEmpty)
                          ? 40
                          : 12,
                      top: 12,
                      bottom: 12,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                if (widget.isFocused || widget.controller.text.isNotEmpty)
                  Positioned(
                    right: 8,
                    child: GestureDetector(
                      onTap: widget.onClearPressed,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          widget.controller.text.isNotEmpty
                              ? Icons.clear
                              : Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.onSearchPressed,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.color1, AppColors.color2],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSubtitle() {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            S.of(context).property_types,
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
            speed: Duration(milliseconds: 100),
          ),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
      ),
    );
  }
}
