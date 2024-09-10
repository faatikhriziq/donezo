import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_form_validation_event.dart';
part 'task_form_validation_state.dart';

class TaskFormValidationBloc
    extends Bloc<TaskFormValidationEvent, TaskFormValidationState> {
  TaskFormValidationBloc() : super(TaskFormValidationInitial()) {
    on<TaskFormValidationValidate>((event, emit) {
      final Map<String, List<String>> errors = {
        'taskTitle': [],
        'taskDueDate': [],
        'taskCategory': [],
        'category': [],
        'description': [],
        'todo': [],
      };

      if (event.taskTitle.isEmpty) {
        errors['taskTitle']!.add('Task Title is Required');
      } else if (event.taskDueDate.isEmpty) {
        errors['taskDueDate']!.add('Due Date is Required');
      } else if (event.taskDueDate.first!.isBefore(DateTime.now())) {
        errors['taskDueDate']!.add('Due Date must be in the future');
      } else if (event.taskCategory == null) {
        errors['taskCategory']!.add('Task Category is Required');
      } else if (event.description.isEmpty) {
        errors['description']!.add('Description is Required');
      }

      if (errors['taskTitle']!.isNotEmpty ||
          errors['taskDueDate']!.isNotEmpty ||
          errors['taskCategory']!.isNotEmpty ||
          errors['description']!.isNotEmpty) {
        emit(TaskFormValidationInvalid(message: errors));
      } else {
        emit(TaskFormValidationValid());
      }
    });
  }
}
