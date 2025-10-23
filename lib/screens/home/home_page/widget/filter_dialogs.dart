// widgets/filter_dialogs.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/home_page/widget/translation_utils.dart';

class FilterDialogs {
  static void showRentDialog(
    BuildContext context,
    String? selectedPropertyType,
    String? selectedTime,
    String? selectedPrice,
    Function(String?, String?, String?) onFiltersChanged,
  ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Filter Dialog',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        String localSelectedPlace = selectedPropertyType ?? 'ທັງໝົດ';
        String localSelectedTime = selectedTime ?? 'ທັງໝົດ';
        String localSelectedPrice = selectedPrice ?? 'ທັງໝົດ';

        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            child: Container(
              width: 235,
              margin: const EdgeInsets.only(right: 16, bottom: 16),
              padding: const EdgeInsets.all(16),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).accommodation_zone,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                localSelectedPlace = 'ທັງໝົດ';
                                localSelectedTime = 'ທັງໝົດ';
                                localSelectedPrice = 'ທັງໝົດ';
                              });
                              onFiltersChanged('ທັງໝົດ', 'ທັງໝົດ', 'ທັງໝົດ');
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              S.of(context).reset,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      _buildRadioGroup(
                        context,
                        S.of(context).accommodation_zone,
                        ['ທັງໝົດ', 'ແຊຫ້ອງ', 'ບໍ່ແຊຫ້ອງ'],
                        localSelectedPlace,
                        (val) => setState(() => localSelectedPlace = val),
                      ),
                      Divider(),
                      Text(
                        S.of(context).time,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRadioGroup(
                        context,
                        S.of(context).time,
                        ['ທັງໝົດ', 'ລ່າສຸດ', 'ດົນສຸດ'],
                        localSelectedTime,
                        (val) => setState(() => localSelectedTime = val),
                      ),
                      Divider(),
                      Text(
                        S.of(context).price,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRadioGroup(
                        context,
                        S.of(context).price,
                        ['ທັງໝົດ', 'ຖືກສຸດ', 'ແພງສຸດ'],
                        localSelectedPrice,
                        (val) => setState(() => localSelectedPrice = val),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(S.of(context).cancel),
                          ),
                          const SizedBox(width: 6),
                          ElevatedButton(
                            onPressed: () {
                              onFiltersChanged(
                                localSelectedPlace,
                                localSelectedTime,
                                localSelectedPrice,
                              );
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade200,
                            ),
                            child: Text(S.of(context).understood),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  static void showSaleDialog(
    BuildContext context,
    String? selectedTime,
    String? selectedPrice,
    Function(String?, String?) onFiltersChanged,
  ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Filter Dialog',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );

        String localSelectedTime = selectedTime ?? 'ທັງໝົດ';
        String localSelectedPrice = selectedPrice ?? 'ທັງໝົດ';

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              child: Container(
                width: 235,
                margin: const EdgeInsets.only(right: 16, bottom: 16),
                padding: const EdgeInsets.all(16),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).time,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  localSelectedTime = 'ທັງໝົດ';
                                  localSelectedPrice = 'ທັງໝົດ';
                                });
                                onFiltersChanged('ທັງໝົດ', 'ທັງໝົດ');
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                S.of(context).reset,
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        _buildRadioGroup(
                          context,
                          S.of(context).time,
                          ['ທັງໝົດ', 'ລ່າສຸດ', 'ດົນສຸດ'],
                          localSelectedTime,
                          (val) => setState(() => localSelectedTime = val),
                        ),
                        Divider(),
                        Text(
                          S.of(context).price,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildRadioGroup(
                          context,
                          S.of(context).price,
                          ['ທັງໝົດ', 'ຖືກສຸດ', 'ແພງສຸດ'],
                          localSelectedPrice,
                          (val) => setState(() => localSelectedPrice = val),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(S.of(context).cancel),
                            ),
                            const SizedBox(width: 6),
                            ElevatedButton(
                              onPressed: () {
                                onFiltersChanged(
                                  localSelectedTime,
                                  localSelectedPrice,
                                );
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade200,
                              ),
                              child: Text(S.of(context).understood),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildRadioGroup(
    BuildContext context,
    String groupName,
    List<String> options,
    String selectedValue,
    void Function(String) onChanged,
  ) {
    return Column(
      children: options.map((option) {
        String displayText = option;
        // Translate the display text based on the group
        if (groupName == S.of(context).accommodation_zone) {
          displayText = TranslationUtils.translateRoomSharing(option, context);
        } else if (groupName == S.of(context).time) {
          displayText = TranslationUtils.translateTime(option, context);
        } else if (groupName == S.of(context).price) {
          displayText = TranslationUtils.translatePrice(option, context);
        }

        return RadioListTile<String>(
          title: Text(displayText),
          value: option,
          // ignore: deprecated_member_use
          groupValue: selectedValue,
          // ignore: deprecated_member_use
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          dense: true,
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        );
      }).toList(),
    );
  }
}