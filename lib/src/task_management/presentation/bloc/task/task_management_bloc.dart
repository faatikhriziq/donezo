import 'dart:developer';

import 'package:donezo/core/di/injection_container.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:donezo/src/task_management/domain/usecases/get_task_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';

part 'task_management_event.dart';
part 'task_management_state.dart';

class TaskManagementBloc
    extends Bloc<TaskManagementEvent, TaskManagementState> {
  final GetTaskUseCase getTaskUseCase;
  TaskManagementBloc(this.getTaskUseCase) : super(TaskManagementInitial()) {
    on<TaskManagementGetTasks>((event, emit) async {
      emit(TaskManagementLoading());
      log("Loading tasks");
      try {
        final result = await getTaskUseCase.call(sl<NoParams>());
        if (result is DataStateSuccess) {
          log("Tasks: ${result.data!}");
          emit(TaskManagementLoaded(tasks: result.data!));
        } else if (result is DataStateError) {
          emit(const TaskManagementError(message: "Failed to get tasks"));
          log(result.error!);
        }
      } catch (e) {
        emit(
            const TaskManagementError(message: "An unexpected error occurred"));
        log("An unexpected error occurred");
      }
    });
  }
}
