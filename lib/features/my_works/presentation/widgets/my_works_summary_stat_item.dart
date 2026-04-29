import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class MyWorksSummaryStatItem extends StatelessWidget {
  const MyWorksSummaryStatItem({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          value,
          style: font22w700.copyWith(color: const Color(0xFFFFFFFF)),
        ),
        AppText(
          label,
          style: font12w400.copyWith(color: const Color(0xFFA7F3D0)),
        ),
      ],
    );
  }
}
