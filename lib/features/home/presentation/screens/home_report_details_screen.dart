import 'package:flutter/material.dart';
import 'package:yallakhadra/features/home/domain/entities/home_nearby_report_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_report_details_body.dart';

class HomeReportDetailsScreen extends StatelessWidget {
  final HomeNearbyReportEntity report;

  const HomeReportDetailsScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeReportDetailsBody(report: report));
  }
}
