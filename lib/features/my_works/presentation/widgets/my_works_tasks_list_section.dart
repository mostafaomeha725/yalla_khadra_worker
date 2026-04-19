import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_task_card.dart';
import 'package:yallakhadra/features/my_works/presentation/widgets/my_works_task_card_no_image.dart';

class MyWorksTasksListSection extends StatelessWidget {
  const MyWorksTasksListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyWorksTaskCard(
          imageUrl: 'https://picsum.photos/id/1059/200/200',
          title: 'Al Wahda Street, near',
          time: '10:30 AM',
          duration: '45 min',
        ),
        SizedBox(height: 8.h),
        const MyWorksTaskCard(
          imageUrl: 'https://picsum.photos/id/1011/200/200',
          title: 'Khalifa Park, East Entrance',
          time: '9:15 AM',
          duration: '38 min',
        ),
        SizedBox(height: 8.h),
        const MyWorksTaskCardNoImage(
          title: 'Marina Beach Area',
          time: '4:20 PM',
          duration: '52 min',
        ),
        SizedBox(height: 8.h),
        const MyWorksTaskCard(
          imageUrl: 'https://picsum.photos/id/1027/200/200',
          title: 'Downtown Square',
          time: '2:10 PM',
          duration: '41 min',
        ),
        SizedBox(height: 8.h),
        const MyWorksTaskCard(
          imageUrl: 'https://picsum.photos/id/1074/200/200',
          title: 'Community Park West',
          time: '11:30 AM',
          duration: '55 min',
        ),
      ],
    );
  }
}
