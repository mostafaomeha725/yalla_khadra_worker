import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/enums/waste_type.dart';
import 'package:yallakhadra/core/theme/styles.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';
import 'package:yallakhadra/core/widgets/custom_text.dart';

class HomeCurrentCleanupWasteDetailsCard extends StatelessWidget {
  final WasteType? selectedWasteType;
  final ValueChanged<WasteType?> onWasteTypeChanged;
  final TextEditingController finalWeightController;

  const HomeCurrentCleanupWasteDetailsCard({
    super.key,
    required this.selectedWasteType,
    required this.onWasteTypeChanged,
    required this.finalWeightController,
  });

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
          DropdownButtonHideUnderline(
            child: DropdownButton2<WasteType>(
              isExpanded: true,
              hint: AppText(
                'Select waste type',
                style: font14w500.copyWith(color: const Color(0xFF94A3B8)),
                alignment: AlignmentDirectional.centerStart,
              ),
              value: selectedWasteType,
              onChanged: onWasteTypeChanged,
              items: WasteType.values
                  .where((WasteType item) => item != WasteType.unknown)
                  .map(
                    (WasteType item) => DropdownMenuItem<WasteType>(
                      value: item,
                      child: AppText(
                        item.label,
                        style: font14w500,
                        alignment: AlignmentDirectional.centerStart,
                      ),
                    ),
                  )
                  .toList(growable: false),
              buttonStyleData: ButtonStyleData(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  color: const Color(0xFFF8FAFC),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                maxHeight: 260.h,
              ),
              menuItemStyleData: MenuItemStyleData(height: 42.h),
              iconStyleData: IconStyleData(
                icon: Icon(Icons.arrow_drop_down, size: 22.sp),
              ),
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
              horizontal: 24.w,
              vertical: 10.h,
            ),
          ),
        ],
      ),
    );
  }
}
