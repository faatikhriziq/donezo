part of 'task_management_bloc.dart';

abstract class TaskManagementState extends Equatable {
  const TaskManagementState();  

  @override
  List<Object> get props => [];
}
class TaskManagementInitial extends TaskManagementState {}
