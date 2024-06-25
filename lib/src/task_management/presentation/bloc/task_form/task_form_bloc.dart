import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_form_event.dart';
part 'task_form_state.dart';

class TaskFormBloc extends Bloc<TaskFormEvent, TaskFormState> {
  TaskFormBloc() : super(TaskFormInitial()) {
    on<TaskFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
