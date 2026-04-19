import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_content_section.dart';

class MyWorksScreenBody extends StatelessWidget {
  const MyWorksScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppLightColors.defaultBackground,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AppBrandHeader(),
            const Expanded(child: MyWorksContentSection()),
          ],
        ),
      ),
    );
  }
}
