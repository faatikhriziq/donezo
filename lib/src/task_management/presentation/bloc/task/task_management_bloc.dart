

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_management_event.dart';
part 'task_management_state.dart';

class TaskManagementBloc extends Bloc<TaskManagementEvent, TaskManagementState> {
  TaskManagementBloc() : super(TaskManagementInitial()) {
    on<TaskManagementEvent>((event, emit) {
      
    });
  }
}
