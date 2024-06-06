import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String todo;

  const TodoEntity({required this.id, required this.todo});

  @override
  List<Object?> get props => [
        id,
        todo
      ];
}
