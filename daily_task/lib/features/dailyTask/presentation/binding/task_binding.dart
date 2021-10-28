import 'package:daily_task/features/dailyTask/presentation/controller/task_controller.dart';
import 'package:get/instance_manager.dart';

import '../../../../injection_container.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController(
        addTask: sl(),
        deleteTask: sl(),
        updateTask: sl(),
        getTask: sl(),
        getNotification: sl(),
        turnOnNotification: sl(),
        openDatabase: sl()));
  }
}
