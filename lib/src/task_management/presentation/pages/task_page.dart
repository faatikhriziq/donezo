import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donezo/config/routes/app_routes.dart';
import 'package:donezo/src/task_management/presentation/bloc/task/task_management_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../core/widgets/task_card.dart';
import '../../data/datasources/task_datasource.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void getTasks() async {
    final taskDatasource =
        TaskDatasource(firestore: FirebaseFirestore.instance);
    final tasks = await taskDatasource.getTasks();
    log(tasks.toString());
  }

  @override
  void initState() {
    super.initState();
    getTasks();
    context.read<TaskManagementBloc>().add(TaskManagementGetTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
      ),
      body: RefreshIndicator(
        color: AppColor.primary,
        onRefresh: () async {
          setState(() {
            context.read<TaskManagementBloc>().add(TaskManagementGetTasks());
          });
        },
        child: BlocBuilder<TaskManagementBloc, TaskManagementState>(
          builder: (context, state) {
            if (state is TaskManagementLoading ||
                state is TaskManagementLoaded) {
              return Skeletonizer(
                enabled: state is TaskManagementLoading ? true : false,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount:
                      state is TaskManagementLoaded ? state.tasks.length : 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskCard(
                        title: state is TaskManagementLoaded
                            ? state.tasks[index].title
                            : BoneMock.title,
                        category: state is TaskManagementLoaded
                            ? state.tasks[index].category
                            : BoneMock.email,
                        percent: state is TaskManagementLoaded
                            ? state.tasks[index].percentageCompleted!
                            : 0.0,
                        task: state is TaskManagementLoaded
                            ? state.tasks[index].todos?.length ?? 0
                            : 10,
                        textPercent: state is TaskManagementLoaded
                            ? "${(state.tasks[index].percentageCompleted! * 100).round()} %"
                            : '20 %',
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: Text('Failed to load tasks'),
              );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: FloatingActionButton(
          onPressed: () async {
            final bool? shouldRefresh =
                await context.push<bool>(AppRoutes.taskForm);
            if (shouldRefresh != null && shouldRefresh) {
              if (context.mounted) {
                context
                    .read<TaskManagementBloc>()
                    .add(TaskManagementGetTasks());
              }
            }
          },
          backgroundColor: AppColor.maroon,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
