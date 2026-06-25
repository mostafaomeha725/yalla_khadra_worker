import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class MyWorksMetaRow extends StatelessWidget {
  final int completedCount;

  const MyWorksMetaRow({super.key, required this.completedCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          '$completedCount completed tasks',
          style: font12w500.copyWith(color: const Color(0xFF374151)),
        ),
        // const Spacer(),
        // BounceIt(
        //   onPressed: () {},
        //   child: AppText(
        //     'Filter',
        //     style: font12w500.copyWith(color: const Color(0xFF10B981)),
        //   ),
        // ),
      ],
    );
  }
}
