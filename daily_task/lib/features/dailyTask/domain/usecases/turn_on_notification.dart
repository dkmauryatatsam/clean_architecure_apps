import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/domain/repositories/local_repository.dart';

class TurnOnNotification {
  final LocalRepository localRepository;
  TurnOnNotification({
    required this.localRepository,
  });

  Future<void> call(TaskEntity task) {
    return localRepository.turnOnNotification(task);
  }
}
