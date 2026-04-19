import 'package:flutter/material.dart';
import 'package:yallakhadra/core/theme/light_colors.dart';
import 'package:yallakhadra/core/widgets/app_brand_header.dart';
import 'package:yallakhadra/features/ai_scan/presentation/widgets/ai_scan_content_section.dart';

class AiScanScreenBody extends StatelessWidget {
  const AiScanScreenBody({super.key});

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
            const Expanded(child: AiScanContentSection()),
          ],
        ),
      ),
    );
  }
}
