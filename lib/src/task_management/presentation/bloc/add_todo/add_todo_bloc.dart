import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoListBloc extends Bloc<AddTodoEvent, AddTodoState> {
  AddTodoListBloc() : super(const AddTodoInitial([])) {
    on<AddTodoStoreToListEvent>((event, emit) {
      final List<String> updatedList = List<String>.from(state.todoList)..add(event.todo);
      emit(AddTodoList(updatedList));
    });

    on<AddTodoRemoveFromListEvent>((event, emit) {
      final List<String> updatedList = List<String>.from(state.todoList)..removeAt(event.index);
      emit(AddTodoList(updatedList));
    });
  }
}
