import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../config/theme/app_color.dart';
import '../bloc/add_todo/add_todo_bloc.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final int index;
  const TodoCard({
    super.key,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(
                      UniconsLine.check_circle,
                      size: 15,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Task',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              context.read<AddTodoListBloc>().add(AddTodoRemoveFromListEvent(todo: title, index: index));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.maroon,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                UniconsLine.trash_alt,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
