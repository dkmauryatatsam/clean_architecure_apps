import 'dart:developer';

import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/add_task.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/delete_task.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/get_notification.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/get_task.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/open_database.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/turn_on_notification.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/update_task.dart';
import 'package:get/get.dart';

enum PageState { initial, loading, loaded, failure }

class TaskController extends GetxController {
  final AddTask addTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;
  final GetTask getTask;
  final GetNotification getNotification;
  final TurnOnNotification turnOnNotification;
  final OpenDatabase openDatabase;
  TaskController({
    required this.addTask,
    required this.deleteTask,
    required this.updateTask,
    required this.getTask,
    required this.getNotification,
    required this.turnOnNotification,
    required this.openDatabase,
  });

  Rx pageState = Rx<PageState>(PageState.initial);
  final RxList<TaskEntity> _task = RxList([]);
  List<TaskEntity> get task => _task;

  Future<void> addNewTask({required TaskEntity task}) async {
    try {
      await addTask(task);
      await getAllTask();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteExistingTask({required TaskEntity task}) async {
    try {
      await deleteTask(task);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateExistingTask({required TaskEntity task}) async {
    try {
      await updateTask(task);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAllTask() async {
    try {
      final taskData = await getTask();
      _task.value = taskData;
    } catch (e) {
      log("data not found");
    }
  }

  Future<void> getNotifications({required TaskEntity task}) async {
    try {
      await getNotification(task);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> turnOnNotifications({required TaskEntity task}) async {
    try {
      await turnOnNotification(task);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> openDatabases() async {
    try {
      await openDatabase();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> onInit() async {
    await getAllTask();
    super.onInit();
  }
}
