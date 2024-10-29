import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:donezo/src/task_management/domain/entities/todo_entity.dart';
import 'package:donezo/src/task_management/domain/repositories/task_repository.dart';

import '../datasources/task_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource _taskDatasource;

  TaskRepositoryImpl({
    required TaskDatasource taskDatasource,
  }) : _taskDatasource = taskDatasource;

  @override
  Future<DataState<TaskEntity>> addTask(
      TaskEntity task, List<Map<String, dynamic>> todo) async {
    try {
      await _taskDatasource.addTaskWithTodos(
        task.title,
        task.category,
        task.description,
        task.dueDate,
        todo,
      );
      return DataState.success(
        TaskEntity(
          title: task.title,
          category: task.category,
          description: task.description,
          dueDate: task.dueDate,
          isCompleted: task.isCompleted,
        ),
      );
    } catch (e) {
      return DataState.error('Failed to add task : $e');
    }
  }

  @override
  Future<TodoEntity> addTodoTask() {
    // TODO: implement addTodoTask
    throw UnimplementedError();
  }

  @override
  Future<DataState<String>> addCategory(String name) async {
    try {
      await _taskDatasource.addCategory(name);
      return DataState.success(name);
    } catch (e) {
      return DataState.error('Failed to add category : $e');
    }
  }

  @override
  Future<DataState<List<TaskEntity>>> getTask() async {
    try {
      final getTask = await _taskDatasource.getTasks();
      final tasks = getTask
          .map((task) => TaskEntity(
              title: task['title'],
              category: task['category'],
              description: task['description'],
              dueDate: task['dueDate'].toDate(),
              isCompleted: task['isCompleted'],
              percentageCompleted: task['completedPercentage'],
              todos: task['todos']
                  .map<TodoEntity>((todo) => TodoEntity(
                        todo: todo['title'],
                        isCompleted: todo['isCompleted'],
                      ))
                  .toList()))
          .toList();
      return DataState.success(tasks);
    } catch (e) {
      return DataState.error('Failed to get task : $e');
    }
  }
}
