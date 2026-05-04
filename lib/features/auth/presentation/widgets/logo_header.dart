import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/constants/app_assets.dart';
import 'package:yallakhadra/core/widgets/app_asset.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key, required this.size});
  final int size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 30.r,
            offset: const Offset(0, 10),
          ),

          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 2.r,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: AppAsset(assetName: Assets.logomini, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
