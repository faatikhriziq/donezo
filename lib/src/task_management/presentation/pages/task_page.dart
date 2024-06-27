import 'package:donezo/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../core/widgets/task_card.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Management'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Task Overview',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TaskCard(
                category: 'Digital Product Design',
                percent: 0.40,
                task: 10,
                textPercent: '40%',
                title: 'Laundry App Design',
              ),
              SizedBox(height: 20),
              Text(
                '24 July 2021',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TaskCard(
                category: 'Digital Product Design',
                percent: 0.40,
                task: 10,
                textPercent: '40%',
                title: 'Laundry App Design',
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: FloatingActionButton(
            onPressed: () {
              context.push(AppRoutes.taskForm);
            },
            child: const Icon(Icons.add),
            backgroundColor: AppColor.maroon,
            shape: CircleBorder(),
          ),
        ));
  }
}
