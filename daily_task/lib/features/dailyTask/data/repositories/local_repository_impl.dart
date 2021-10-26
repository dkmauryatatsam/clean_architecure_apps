import 'package:daily_task/features/dailyTask/data/datasources/local_data_source.dart';
import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/domain/repositories/local_repository.dart';
import 'package:sembast/sembast.dart';

class LocalRepositoryImpl implements LocalRepository {
  final LocalDataSource localDataSource;
  LocalRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<void> addNewTask(TaskEntity task) {
    return localDataSource.addNewTask(task);
  }

  @override
  Future<void> deleteTask(TaskEntity task) {
    return localDataSource.deleteTask(task);
  }

  @override
  Future<List<TaskEntity>> getAllTask() {
    return localDataSource.getAllTask();
  }

  @override
  Future<void> getNotification(TaskEntity task) {
    return localDataSource.getNotification(task);
  }

  @override
  Future<Database> openDatabase() {
    return localDataSource.openDatabase();
  }

  @override
  Future<void> turnOnNotification(TaskEntity task) {
    return localDataSource.turnOnNotification(task);
  }

  @override
  Future<void> updateTask(TaskEntity task) {
    return localDataSource.updateTask(task);
  }
}
