// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_form_bloc.dart';

sealed class TaskFormEvent extends Equatable {
  const TaskFormEvent();

  @override
  List<Object> get props => [];
}

class TaskFormAddCategory extends TaskFormEvent {
  final String category;

  const TaskFormAddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class TaskFormGetCategories extends TaskFormEvent {}

class TaskFormAddTask extends TaskFormEvent {
  final AddTaskParams params;

  const TaskFormAddTask(this.params);

  @override
  List<Object> get props => [params];
}
