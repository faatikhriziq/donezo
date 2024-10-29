import 'package:donezo/src/task_management/domain/entities/todo_entity.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  String title;
  String description;
  DateTime dueDate;
  String category;
  bool isCompleted;
  double? percentageCompleted;
  List<TodoEntity>? todos;

  TaskEntity({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
    this.percentageCompleted,
    this.todos,
  });

  @override
  List<Object?> get props =>
      [title, description, dueDate, isCompleted, category, todos];
}
