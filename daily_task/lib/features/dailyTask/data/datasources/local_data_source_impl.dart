import 'dart:async';

import 'package:daily_task/features/dailyTask/data/datasources/local_data_source.dart';
import 'package:daily_task/features/dailyTask/data/models/task_model.dart';
import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

const String MAP_STORE = "MAP_STORE_TASK";

class LocalDataSourceImpl implements LocalDataSource {
  Completer<Database>? _dbOpenCompleter;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<Database> get _db async => _dbOpenCompleter!.future;
  final _taskStore = intMapStoreFactory.store(MAP_STORE);

  Future _initDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'task.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter!.complete(database);
  }

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
    _taskStore.add(await _db, newTask);
  }

  @override
  Future<void> deleteTask(TaskEntity task) async {
    final finder = Finder(filter: Filter.byKey(task.id));
    _taskStore.delete(await _db, finder: finder);
  }

  @override
  Future<List<TaskEntity>> getAllTask() async {
    final finder = Finder(sortOrders: [SortOrder('id')]);
    final recordSnapshot = await _taskStore.find(await _db, finder: finder);

    return recordSnapshot.map((task) {
      final taskData = TaskModel.fromJson(task.value);
      taskData.id = task.key;
      return taskData;
    }).toList();
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
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _initDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  @override
  Future<void> turnOnNotification(TaskEntity task) async {
    final updatedTask = TaskModel(
      title: task.title,
      colorIndex: task.colorIndex,
      time: task.time,
      isComplete: task.isComplete,
      isNotification: task.isNotification == true ? false : true,
      taskType: task.taskType,
    ).toJson();
    final finder = Finder(filter: Filter.byKey(task.id));
    _taskStore.update(await _db, updatedTask, finder: finder);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final updatedTask = TaskModel(
      title: task.title,
      colorIndex: task.colorIndex,
      time: task.time,
      isComplete: task.isComplete == true ? false : true,
      isNotification: task.isNotification,
      taskType: task.taskType,
    ).toJson();
    final finder = Finder(filter: Filter.byKey(task.id));
    _taskStore.update(await _db, updatedTask, finder: finder);
  }
}
