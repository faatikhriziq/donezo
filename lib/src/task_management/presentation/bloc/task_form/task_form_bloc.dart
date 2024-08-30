// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:donezo/src/task_management/domain/usecases/add_category_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';

part 'task_form_event.dart';
part 'task_form_state.dart';

class TaskFormBloc extends Bloc<TaskFormEvent, TaskFormState> {
  final AddCategoryUseCase addCategoryUseCase;
  TaskFormBloc({required this.addCategoryUseCase}) : super(TaskFormInitial()) {
    on<TaskFormAddCategory>((event, emit) {
      emit(TaskFormAddCategoryLoading());
      final result = addCategoryUseCase.call(event.category);
      if (result is DataStateSuccess) {
        emit(TaskFormAddCategorySuccess());
      } else if (result is DataStateError) {
        emit(const TaskFormAddCategoryError("Failed to add category"));
      }
    });
  }
}
