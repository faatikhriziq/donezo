import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/core/resources/params.dart';
import 'package:donezo/core/usecase/usecase.dart';
import 'package:donezo/src/task_management/domain/entities/task_entity.dart';
import 'package:donezo/src/task_management/domain/repositories/task_repository.dart';

class GetTaskUseCase extends UseCase<DataState<List<TaskEntity>>, NoParams> {
  final TaskRepository taskRepository;

  GetTaskUseCase(this.taskRepository);
  @override
  Future<DataState<List<TaskEntity>>> call(params) async {
    return await taskRepository.getTask();
  }
}
