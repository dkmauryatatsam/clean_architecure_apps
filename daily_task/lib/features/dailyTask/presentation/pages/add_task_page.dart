import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/presentation/controller/task_controller.dart';
import 'package:daily_task/features/dailyTask/presentation/widgets/common.dart';
import 'package:daily_task/features/dailyTask/presentation/widgets/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.find<TaskController>();
  final TextEditingController taskEditingController = TextEditingController();
  int _selectedTaskTypeIndex = 0;
  DateTime _selectedTime = DateTime.now();
  @override
  void dispose() {
    taskEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Task"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addNewTaskWidget(),
              _divider(),
              _taskTypeWidget(),
              _divider(),
              _chooseTimeWidget(),
              _addTaskButtonWidget(),
            ],
          ),
        ));
  }

  _addNewTaskWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.blueGrey.withOpacity(.2)),
      child: Scrollbar(
        thickness: 6,
        child: TextField(
          controller: taskEditingController,
          maxLines: 4,
          decoration: const InputDecoration(
              hintText: "e.g morning walk", border: InputBorder.none),
        ),
      ),
    );
  }

  _divider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1.5,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _taskTypeWidget() {
    return SizedBox(
      height: 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: taskTypeList.map((name) {
          var index = taskTypeList.indexOf(name);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTaskTypeIndex = index;
              });
            },
            child: _selectedTaskTypeIndex == index
                ? Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: taskTypeListColor[index],
                      ),
                      child: Center(
                        child: Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: taskTypeListColor[index],
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child!);
        });
    if (pickTime != null &&
        pickTime !=
            TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute)) {
      setState(() {
        _selectedTime = DateTime(_selectedTime.year, _selectedTime.month,
            _selectedTime.day, pickTime.hour, pickTime.minute);
      });
    }
  }

  _chooseTimeWidget() {
    return GestureDetector(
      onTap: () {
        _selectTime();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose Time",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
              "${DateFormat("hh:mm a").format(DateTime.now())} - ${DateFormat("hh:mm a").format(_selectedTime)}"),
        ],
      ),
    );
  }

  _addTaskButtonWidget() {
    return Expanded(
      child: GestureDetector(
        onTap: submitNewTask,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(colors: [
                Colors.indigo,
                color6FADE4,
              ], end: Alignment.topLeft, begin: Alignment.topRight),
            ),
            child: const Text(
              "Add task",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  void submitNewTask() {
    if (taskEditingController.text.isEmpty) {
      return;
    }
    taskController.addNewTask(
        task: TaskEntity(
      title: taskEditingController.text,
      colorIndex: _selectedTaskTypeIndex.toString(),
      time: _selectedTime.toString(),
      taskType: taskTypeList[_selectedTaskTypeIndex],
      isComplete: false,
      isNotification: false,
    ));
    print("add succesfully");
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
      Get.snackbar(taskEditingController.text, "Addded",
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
