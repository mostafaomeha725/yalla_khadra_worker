import 'package:flutter/material.dart';
import 'package:yallakhadra/features/ai_scan/presentation/screens/ai_scan_screen.dart';
import 'package:yallakhadra/features/home/presentation/screens/home_screen.dart';
import 'package:yallakhadra/features/my_works/presentation/screens/my_works_screen.dart';
import 'package:yallakhadra/features/reports/presentation/screens/reports_screen.dart';

class CustomerNavData {
  static final List<Map<String, dynamic>> items = [
    {'label': 'Home', 'icon': Icons.home_rounded},
    {'label': 'Reports', 'icon': Icons.description_outlined},
    {'label': 'AI Scan', 'icon': Icons.qr_code_scanner_rounded},
    {'label': 'My Works', 'icon': Icons.work_outline_rounded},
  ];

  static final List<Widget> screens = [
    const HomeScreen(),
    const ReportsScreen(),
    const AiScanScreen(),
    const MyWorksScreen(),
  ];
}
