part of 'add_todo_bloc.dart';

sealed class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

final class AddTodoStoreToListEvent extends AddTodoEvent {
  final String todo;

  const AddTodoStoreToListEvent({
    required this.todo,
  });

  @override
  List<Object> get props => [
        todo
      ];
}

final class AddTodoRemoveFromListEvent extends AddTodoEvent {
  final String todo;
  final int index;

  const AddTodoRemoveFromListEvent({
    required this.index,
    required this.todo,
  });

  @override
  List<Object> get props => [
        todo
      ];
}

final class AddTodoStoreToDatabase extends AddTodoEvent {
  final String todo;

  const AddTodoStoreToDatabase({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}
