part of 'task_form_validation_bloc.dart';

sealed class TaskFormValidationEvent extends Equatable {
  const TaskFormValidationEvent();

  @override
  List<Object> get props => [];
}

final class TaskFormValidationValidate extends TaskFormValidationEvent {
  final String taskTitle;
  final List<DateTime?> taskDueDate;
  final String? taskCategory;
  final String description;

  const TaskFormValidationValidate( {
    required this.taskTitle,
    required this.taskDueDate,
    required this.taskCategory,
    required this.description,
  });

  @override
  List<Object> get props => [];
}