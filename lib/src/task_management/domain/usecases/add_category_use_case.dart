import 'package:donezo/core/resources/data_state.dart';
import 'package:donezo/core/usecase/usecase.dart';

import '../repositories/task_repository.dart';

class AddCategoryUseCase extends UseCase<void, String> {
  final TaskRepository _taskRepository;

  AddCategoryUseCase({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;
  @override
  Future<DataState<String>> call(String params) async {
    return await _taskRepository.addCategory(params);
  }
}
