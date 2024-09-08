// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:donezo/core/usecase/usecase.dart';
import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:donezo/src/task_management/domain/repositories/task_repository.dart';

class AddTaskUseCase extends UseCase<DataState<TaskEntity>, AddTaskParams> {
  final TaskRepository taskRepository;
  AddTaskUseCase({
    required this.taskRepository,
  });

  @override
  Future<DataState<TaskEntity>> call(AddTaskParams params) async {
    return await taskRepository.addTask(params.task, params.todo);
  }
}
