part of 'add_todo_bloc.dart';

sealed class AddTodoState extends Equatable {
  final List<String> todoList;
  const AddTodoState(this.todoList);
  
  @override
  List<Object> get props => [];
}

final class AddTodoInitial extends AddTodoState {
  const AddTodoInitial(super.todoList);
}

final class AddTodoList extends AddTodoState {
  const AddTodoList(super.todoList);

 

  @override
  List<Object> get props => [todoList];
}
