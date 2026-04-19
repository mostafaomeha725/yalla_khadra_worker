import 'dart:ui';

import 'package:yallakhadra/core/widgets/nav_bar_item.dart';
import 'package:yallakhadra/core/widgets/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<Map<String, dynamic>> navItems;
  final NavigationState navState;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.navItems,
    required this.navState,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius navBorderRadius = BorderRadius.circular(30.r);

    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(bottom: 12.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: navBorderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: navBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: navBorderRadius,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(navItems.length, (index) {
                  return NavBarItem(
                    icon: navItems[index]['icon'],
                    label: navItems[index]['label'],
                    isSelected: navState.selectedIndex == index,
                    onTap: () {
                      onItemTapped(index);
                    },
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
