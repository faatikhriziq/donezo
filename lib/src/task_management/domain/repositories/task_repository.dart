import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:donezo/src/task_management/domain/entities/todo_entity.dart';

abstract class TaskRepository {
  Future<TaskEntity> addTask();
  Future<TodoEntity> addTodoTask();
}
