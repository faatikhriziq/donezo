import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String todo;
  final bool isCompleted;

  const TodoEntity({required this.todo, this.isCompleted = false});

  @override
  List<Object?> get props => [todo];
}
