import 'package:donezo/src/task_management/presentation/bloc/add_todo/add_todo_bloc.dart';
import 'package:get_it/get_it.dart';

void initTaskManagementDependencies(GetIt sl) {
  sl.registerFactory(() => AddTodoListBloc());
}
