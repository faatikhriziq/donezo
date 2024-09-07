import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:unicons/unicons.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String category;
  final int task;
  final double percent;
  final String textPercent;
  const TaskCard({
    super.key,
    required this.title,
    required this.category,
    required this.task,
    required this.percent,
    required this.textPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
          width: 1.3,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 3.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    UniconsLine.check_circle,
                    size: 15,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$task Task',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 35.0,
            lineWidth: 7.0,
            percent: percent,
            center: Text(textPercent),
            progressColor: Colors.green,
          )
        ],
      ),
    );
  }
}
