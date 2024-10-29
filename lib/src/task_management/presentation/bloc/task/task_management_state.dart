part of 'task_management_bloc.dart';

abstract class TaskManagementState extends Equatable {
  const TaskManagementState();  

  @override
  List<Object> get props => [];
}
class TaskManagementInitial extends TaskManagementState {}
class TaskManagementLoading extends TaskManagementState {}
class TaskManagementLoaded extends TaskManagementState {
  final List<TaskEntity> tasks;

  const TaskManagementLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskManagementError extends TaskManagementState {
  final String message;

  const TaskManagementError({required this.message});

  @override
  List<Object> get props => [message];
}