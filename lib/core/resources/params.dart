import 'package:donezo/src/task_management/domain/entities/task_entity.dart';

abstract class Params {}

class NoParams extends Params {}

class SignUpParams extends Params {
  String email;
  String password;

  SignUpParams({
    required this.email,
    required this.password,
  });
}

class SignInParams extends Params {
  String email;
  String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}

class AddTaskParams extends Params {
  TaskEntity task;
  List<Map<String, dynamic>> todo;

  AddTaskParams({
    required this.task,
    required this.todo,
  });
}
