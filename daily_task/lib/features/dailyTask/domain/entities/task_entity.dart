class TaskEntity {
  int? id;
  String title;
  String colorIndex;
  String time;
  String taskType;
  bool isComplete;
  bool isNotification;

  TaskEntity({
    this.id,
    required this.title,
    required this.colorIndex,
    required this.time,
    required this.taskType,
    required this.isComplete,
    required this.isNotification,
  });
}
