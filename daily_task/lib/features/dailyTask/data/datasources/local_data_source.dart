import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:sembast/sembast.dart';

abstract class LocalDataSource {
  Future<void> addNewTask(TaskEntity task);
  Future<void> deleteTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> getNotification(TaskEntity task);
  Future<void> turnOnNotification(TaskEntity task);
  Future<List<TaskEntity>> getAllTask();
  Future<Database> openDatabase();
}
