import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class DividerOr extends StatelessWidget {
  const DividerOr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            S.of(context).or,
            style: TextStyle(
              fontFamily: 'NotoSansLao',
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}