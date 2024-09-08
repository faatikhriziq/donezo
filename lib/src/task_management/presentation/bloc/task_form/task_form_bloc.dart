// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:donezo/core/shared/local_storage/auth_local_storage.dart';
import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:donezo/src/task_management/domain/usecases/add_category_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/usecases/add_task_use_case.dart';

part 'task_form_event.dart';
part 'task_form_state.dart';

class TaskFormBloc extends Bloc<TaskFormEvent, TaskFormState> {
  final AddCategoryUseCase addCategoryUseCase;
  final AddTaskUseCase addTaskUseCase;

  TaskFormBloc({required this.addCategoryUseCase, required this.addTaskUseCase})
      : super(TaskFormInitial()) {
    on<TaskFormAddCategory>((event, emit) async {
      emit(TaskFormAddCategoryLoading());
      final result = await addCategoryUseCase.call(event.category);
      if (result is DataStateSuccess) {
        emit(TaskFormAddCategorySuccess(category: result.data!));
      } else if (result is DataStateError) {
        emit(const TaskFormAddCategoryError("Failed to add category"));
      }
    });

    on<TaskFormGetCategories>((event, emit) async {
      emit(TaskFormCategoryLoading());
      final userId = await getUserId();
      Query<Map<String, dynamic>> categories =
          FirebaseFirestore.instance.collection('categories').where(
                'user_id',
                isEqualTo: userId,
              );
      final result = await categories.get();
      log(result.docs.toString());
      if (result.docs.isNotEmpty) {
        final List<String> categoryList =
            result.docs.map((e) => e['name'].toString()).toList();
        emit(TaskFormCategorySuccess(categoryList));
      } else {
        emit(const TaskFormCategoryError("Failed to get categories"));
      }
    });

    on<TaskFormAddTask>((event, emit) async {
      emit(TaskFormAddTaskLoading());

      final result = await addTaskUseCase.call(event.params);
      if (result is DataStateSuccess) {
        emit(TaskFormAddTaskSuccess(result.data!));
      } else if (result is DataStateError) {
        emit(const TaskFormAddTaskError("Failed to add task"));
      }
    });
  }
}
