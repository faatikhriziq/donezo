part of 'task_form_validation_bloc.dart';

sealed class TaskFormValidationState extends Equatable {
  const TaskFormValidationState();
  
  @override
  List<Object> get props => [];
}

final class TaskFormValidationInitial extends TaskFormValidationState {}


final class TaskFormValidationLoading extends TaskFormValidationState {}

final class TaskFormValidationInvalid extends TaskFormValidationState {
  final Map<String, List<String>> message;

  const TaskFormValidationInvalid({this.message = const {}});

  @override
  List<Object> get props => [
        message
      ];
}

final class TaskFormValidationValid extends TaskFormValidationState {}