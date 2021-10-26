import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/domain/repositories/local_repository.dart';

class UpdateTask {
  final LocalRepository localRepository;
  UpdateTask({
    required this.localRepository,
  });

  Future<void> call(TaskEntity task) {
    return localRepository.updateTask(task);
  }
}
