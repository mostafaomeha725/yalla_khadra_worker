import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeCurrentCleanupWasteDetailsCard extends StatefulWidget {
  const HomeCurrentCleanupWasteDetailsCard({super.key});

  @override
  State<HomeCurrentCleanupWasteDetailsCard> createState() =>
      HomeCurrentCleanupWasteDetailsCardState();
}

class HomeCurrentCleanupWasteDetailsCardState
    extends State<HomeCurrentCleanupWasteDetailsCard> {
  late final TextEditingController finalWasteTypeController;
  late final TextEditingController finalWeightController;

  @override
  void initState() {
    super.initState();
    finalWasteTypeController = TextEditingController();
    finalWeightController = TextEditingController();
  }

  @override
  void dispose() {
    finalWasteTypeController.dispose();
    finalWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Final Waste Details',
            style: font14w700.copyWith(color: const Color(0xFF0F172A)),
          ),
          SizedBox(height: 10.h),
          AppText(
            'Final Waste Type',
            style: font12w500.copyWith(color: const Color(0xFF334155)),
          ),
          SizedBox(height: 6.h),
          AppFormField(
            controller: finalWasteTypeController,
            hintText: 'Final Waste Type',
            borderColor: const Color(0xFFE2E8F0),
            fillColor: const Color(0xFFF8FAFC),
            radius: 10.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
          ),
          SizedBox(height: 10.h),
          AppText(
            'Final Weight (KG)',
            style: font12w500.copyWith(color: const Color(0xFF334155)),
          ),
          SizedBox(height: 6.h),
          AppFormField(
            controller: finalWeightController,
            hintText: 'Enter weight in kg',
            keyboardType: TextInputType.number,
            borderColor: const Color(0xFFE2E8F0),
            fillColor: const Color(0xFFF8FAFC),
            radius: 10.r,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
          ),
        ],
      ),
    );
  }
}
