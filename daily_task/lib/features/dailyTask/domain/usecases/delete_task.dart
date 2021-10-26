import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/domain/repositories/local_repository.dart';

class DeleteTask {
  final LocalRepository localRepository;
  DeleteTask({
    required this.localRepository,
  });

  Future<void> call(TaskEntity task) {
    return localRepository.deleteTask(task);
  }
}
