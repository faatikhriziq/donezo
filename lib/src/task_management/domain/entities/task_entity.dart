import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String category;
  final bool isCompleted;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        isCompleted
      ];
}
