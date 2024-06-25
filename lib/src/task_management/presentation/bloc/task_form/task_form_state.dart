part of 'task_form_bloc.dart';

sealed class TaskFormState extends Equatable {
  const TaskFormState();
  
  @override
  List<Object> get props => [];
}

final class TaskFormInitial extends TaskFormState {}
