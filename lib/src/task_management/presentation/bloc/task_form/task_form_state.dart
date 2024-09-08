part of 'task_form_bloc.dart';

sealed class TaskFormState extends Equatable {
  const TaskFormState();

  @override
  List<Object> get props => [];
}

final class TaskFormInitial extends TaskFormState {}

final class TaskFormAddCategoryLoading extends TaskFormState {}

final class TaskFormAddCategorySuccess extends TaskFormState {
  final String category;

  const TaskFormAddCategorySuccess({required this.category});

  @override
  List<Object> get props => [category];
}

final class TaskFormAddCategoryError extends TaskFormState {
  final String message;

  const TaskFormAddCategoryError(this.message);

  @override
  List<Object> get props => [message];
}

final class TaskFormCategoryLoading extends TaskFormState {}

final class TaskFormCategorySuccess extends TaskFormState {
  final List<String> categories;

  const TaskFormCategorySuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

final class TaskFormCategoryError extends TaskFormState {
  final String message;

  const TaskFormCategoryError(this.message);

  @override
  List<Object> get props => [message];
}

final class TaskFormAddTaskLoading extends TaskFormState {}

final class TaskFormAddTaskSuccess extends TaskFormState {
  final TaskEntity task;

  const TaskFormAddTaskSuccess(this.task);

  @override
  List<Object> get props => [task];
}

final class TaskFormAddTaskError extends TaskFormState {
  final String message;

  const TaskFormAddTaskError(this.message);

  @override
  List<Object> get props => [message];
}
