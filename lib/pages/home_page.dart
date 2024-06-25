import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import '../config/theme/app_color.dart';
import '../core/widgets/card_dashboard.dart';
import '../core/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColor.primary,
              radius: 20,
              child: Icon(
                UniconsLine.user,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Faatikh Riziq',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Your daily adventure starts here!',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(UniconsLine.bars),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              padding: const EdgeInsets.all(12),
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2,
              shrinkWrap: true,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              children: const [
                CardDashboard(
                  color: AppColor.primary,
                  icon: UniconsLine.redo,
                  title: 'Total Task',
                  value: 10,
                ),
                CardDashboard(
                  color: AppColor.goldenRod,
                  icon: UniconsLine.check,
                  title: 'Completed',
                  value: 5,
                ),
                CardDashboard(
                  color: AppColor.maroon,
                  icon: UniconsLine.clock,
                  title: 'Pending',
                  value: 5,
                ),
                CardDashboard(
                  color: AppColor.aqua,
                  icon: UniconsLine.bell,
                  title: 'Reminder',
                  value: 2,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TaskCard(
                    category: 'Digital Product Design',
                    percent: 0.40,
                    task: 10,
                    textPercent: '40%',
                    title: 'Laundry App Design',
                  ),
                  SizedBox(height: 12),
                  TaskCard(
                    category: 'Digital Product Design',
                    percent: 0.40,
                    task: 10,
                    textPercent: '40%',
                    title: 'Laundry App Design',
                  ),
                  SizedBox(height: 12),
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
          ],
        ),
      ),
    );
  }
}
