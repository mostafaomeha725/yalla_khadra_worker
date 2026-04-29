import 'package:yallakhadra/core/widgets/custom_bottom_navbar.dart';
import 'package:yallakhadra/core/widgets/customer_nav_data.dart';
import 'package:yallakhadra/core/widgets/navigation_state.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final bool isAdmin;

  const CustomNavBar({super.key, this.isAdmin = true});

  static void switchToTab(BuildContext context, int index) {
    final _CustomNavBarState? state = context
        .findAncestorStateOfType<_CustomNavBarState>();
    state?.switchToTab(index);
  }

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late NavigationState _navState;
  late List<Map<String, dynamic>> _navItems;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _navState = NavigationState();
    _initializeNavigation();
  }

  void _initializeNavigation() {
    _navItems = CustomerNavData.items;
    _screens = CustomerNavData.screens;
  }

  void goBack() {
    _navState.goBack(() => setState(() {}));
  }

  void switchToTab(int index) {
    if (index < 0 || index >= _screens.length) {
      return;
    }
    _navState.onItemTapped(index, () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _navState.navigationStack.length <= 1,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _navState.handleBackPress(() => setState(() {}));
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff8f9fa),
        body: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _screens[_navState.selectedIndex],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavBar(
                navItems: _navItems,
                navState: _navState,
                onItemTapped: (index) =>
                    _navState.onItemTapped(index, () => setState(() {})),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
