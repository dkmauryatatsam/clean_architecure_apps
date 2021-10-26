import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/domain/repositories/local_repository.dart';

class GetTask {
  final LocalRepository localRepository;
  GetTask({
    required this.localRepository,
  });

  Future<List<TaskEntity>> call() {
    return localRepository.getAllTask();
  }
}
