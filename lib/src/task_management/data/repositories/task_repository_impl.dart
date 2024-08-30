import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:donezo/src/task_management/domain/entities/todo_entity.dart';
import 'package:donezo/src/task_management/domain/repositories/task_repository.dart';

import '../datasources/task_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource _taskDatasource;

  TaskRepositoryImpl({required TaskDatasource taskDatasource}) : _taskDatasource = taskDatasource;

  @override
  Future<DataState<String>> addCategory(String name) async{
    try {
      final result = await _taskDatasource.addCategory(name);
      return DataState.success(name);
    } catch (e) {
      return DataState.error('Failed to add category : $e');
    }
  }

  @override
  Future<TaskEntity> addTask() {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<TodoEntity> addTodoTask() {
    // TODO: implement addTodoTask
    throw UnimplementedError();
  }

}