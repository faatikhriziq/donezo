import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:donezo/src/task_management/domain/entities/todo_entity.dart';

abstract class TaskRepository {
  Future<DataState<TaskEntity>> addTask(
      TaskEntity task, List<Map<String, dynamic>> todo);
  Future<TodoEntity> addTodoTask();
  Future<DataState<String>> addCategory(String name);
}
