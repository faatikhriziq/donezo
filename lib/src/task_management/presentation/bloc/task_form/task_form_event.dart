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
