import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  String title;
  String description;
  DateTime dueDate;
  String category;
  bool isCompleted;

  TaskEntity({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [title, description, dueDate, isCompleted];
}
