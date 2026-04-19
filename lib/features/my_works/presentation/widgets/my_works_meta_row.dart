import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/bouncing_widgets.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class MyWorksMetaRow extends StatelessWidget {
  const MyWorksMetaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          '15 completed tasks',
          style: font12w500.copyWith(color: const Color(0xFF374151)),
        ),
        const Spacer(),
        BounceIt(
          onPressed: () {},
          child: AppText(
            'Filter',
            style: font12w500.copyWith(color: const Color(0xFF10B981)),
          ),
        ),
      ],
    );
  }
}
