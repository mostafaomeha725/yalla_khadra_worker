import 'package:flutter/material.dart';
import 'package:yallakhadra/features/home/domain/entities/home_cleanup_task_entity.dart';
import 'package:yallakhadra/features/home/presentation/widgets/home_current_cleanup_body.dart';

class HomeCurrentCleanupScreen extends StatelessWidget {
  final HomeCleanupTaskEntity task;

  const HomeCurrentCleanupScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeCurrentCleanupBody(task: task));
  }
}
