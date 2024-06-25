import 'package:donezo/src/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/auth/presentation/bloc/auth/auth_bloc.dart';
import '../../src/task_management/presentation/bloc/add_todo/add_todo_bloc.dart';
import '../di/injection_container.dart';

final List<BlocProvider> blocProviders = [
  BlocProvider<AddTodoListBloc>(
    create: (context) => AddTodoListBloc(),
  ),
  BlocProvider<AuthFormBloc>(
    create: (context) => AuthFormBloc(),
  ),
  BlocProvider<AuthBloc>(
    create: (context) => sl<AuthBloc>(),
  ),
];
