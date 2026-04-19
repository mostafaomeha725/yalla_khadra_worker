import 'package:flutter/material.dart';
import 'package:yallakhadra/core/utils/spacing.dart';
import 'package:yallakhadra/features/reports/presentation/widgets/report_list_item_card.dart';

class ReportsListSection extends StatelessWidget {
  const ReportsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReportListItemCard(
          imageUrl: 'https://picsum.photos/id/1059/320/320',
          title: 'Al Reem Island Boulevard',
          distance: '5.1 km',
          timeAgo: '1 day ago',
          wasteType: 'Plastic Bottles',
        ),
        verticalSpacing(10),
        const ReportListItemCard(
          imageUrl: 'https://picsum.photos/id/1011/320/320',
          title: 'Corniche Beach Area',
          distance: '5.8 km',
          timeAgo: '1 day ago',
          wasteType: 'Mixed Waste',
        ),
        verticalSpacing(10),
        const ReportListItemCard(
          imageUrl: 'https://picsum.photos/id/1040/320/320',
          title: 'Yas Island Park',
          distance: '6.3 km',
          timeAgo: '1 day ago',
          wasteType: 'Glass Bottles',
        ),
        verticalSpacing(10),
        const ReportListItemCard(
          imageUrl: 'https://picsum.photos/id/1027/320/320',
          title: 'Al Mina Fish Market',
          distance: '7.2 km',
          timeAgo: '2 days ago',
          wasteType: 'Paper & Cardboard',
        ),
        verticalSpacing(10),
        const ReportListItemCard(
          imageUrl: 'https://picsum.photos/id/1074/320/320',
          title: 'Saadiyat Beach',
          distance: '8.5 km',
          timeAgo: '2 days ago',
          wasteType: 'Plastic Bags',
        ),
      ],
    );
  }
}
