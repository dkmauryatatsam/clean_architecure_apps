import 'dart:async';

import 'package:daily_task/features/dailyTask/data/datasources/local_data_source.dart';
import 'package:daily_task/features/dailyTask/data/models/task_model.dart';
import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sembast/sembast.dart';

const String MAP_STORE = "MAP_STORE_TASK";
const String TASKBOX = "TASKS";

class LocalDataSourceImpl implements LocalDataSource {
  final GetStorage box;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalDataSourceImpl(this.box);

  final _taskStore = intMapStoreFactory.store(MAP_STORE);
  final db = GetStorage();

  @override
  Future<void> addNewTask(TaskEntity task) async {
    final newTask = TaskModel(
      title: task.title,
      colorIndex: task.colorIndex,
      time: task.time,
      isComplete: task.isComplete,
      isNotification: task.isNotification,
      taskType: task.taskType,
    ).toJson();
    await box.write(TASKBOX, newTask);
  }

  @override
  Future<void> deleteTask(TaskEntity task) async {
    throw UnimplementedError();
  }

  @override
  Future<List<TaskEntity>> getAllTask() async {
    final List<TaskEntity> tasks = [];
    final result = await box.read(TASKBOX) as Map<String, dynamic>;
    final task = TaskModel.fromJson(result);
    tasks.add(
      TaskEntity(
        title: task.title,
        colorIndex: task.colorIndex,
        time: task.time,
        taskType: task.taskType,
        isComplete: task.isComplete,
        isNotification: task.isNotification,
      ),
    );
    return tasks;
  }

  @override
  Future<void> getNotification(TaskEntity task) async {
    if (task.isNotification == false) {
//push notification------>
      final dateTime = DateTime.parse(task.time);
      final androidChannel = AndroidNotificationDetails(
        task.id.toString(),
        "daily task notifications",
      );
      final notificationDetail = NotificationDetails(android: androidChannel);
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          task.id!,
          task.title,
          "it's time for ${task.title}",
          Time(dateTime.hour, dateTime.minute, 0),
          notificationDetail);
    } else {
      await flutterLocalNotificationsPlugin.cancel(task.id!);
    }
  }

  @override
  Future<Database> openDatabase() async {
    throw UnimplementedError();
  }

  @override
  Future<void> turnOnNotification(TaskEntity task) async {
    // final updatedTask = TaskModel(
    //   title: task.title,
    //   colorIndex: task.colorIndex,
    //   time: task.time,
    //   isComplete: task.isComplete,
    //   isNotification: task.isNotification == true ? false : true,
    //   taskType: task.taskType,
    // ).toJson();
    // final finder = Finder(filter: Filter.byKey(task.id));
    // _taskStore.update(await _db, updatedTask, finder: finder);
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    // final updatedTask = TaskModel(
    //   title: task.title,
    //   colorIndex: task.colorIndex,
    //   time: task.time,
    //   isComplete: task.isComplete == true ? false : true,
    //   isNotification: task.isNotification,
    //   taskType: task.taskType,
    // ).toJson();
    // final finder = Finder(filter: Filter.byKey(task.id));
    // _taskStore.update(await _db, updatedTask, finder: finder);
    throw UnimplementedError();
  }
}
