import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required String title,
    required String colorIndex,
    required String time,
    required bool isComplete,
    required bool isNotification,
    required String taskType,
  }) : super(
          time: time,
          title: title,
          colorIndex: colorIndex,
          taskType: taskType,
          isComplete: isComplete,
          isNotification: isNotification,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        title: json['title'],
        colorIndex: json['colorIndex'],
        time: json['time'],
        taskType: json['taskType'],
        isComplete: json['isComplete'],
        isNotification: json['isNotification']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "colorIndex": colorIndex,
      "time": time,
      "taskType": taskType,
      "isComplete": isComplete,
      "isNotification": isNotification
    };
  }
}
