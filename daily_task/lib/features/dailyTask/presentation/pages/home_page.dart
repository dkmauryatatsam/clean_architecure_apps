import 'package:daily_task/features/dailyTask/domain/entities/task_entity.dart';
import 'package:daily_task/features/dailyTask/presentation/controller/task_controller.dart';
import 'package:daily_task/features/dailyTask/presentation/widgets/common.dart';
import 'package:daily_task/features/dailyTask/presentation/widgets/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SlidableController _slidableController = SlidableController();
  final TaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _header(),
        _taskListWidget(),
      ],
    ));
  }

  _header() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo,
            color6FADE4,
          ],
          end: Alignment.topLeft,
          begin: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "My Daily Tasks",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Obx(() => Text(
                          "Today you have ${taskController.task.length} task",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(.8),
                          ),
                        )),
                  ],
                ),
                PopupMenuButton<String>(
                  itemBuilder: (_) => taskTypeList.map((value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onSelected: (String value) {
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.filter_list_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          _currentTaskWidget(),
        ],
      ),
    );
  }

  _currentTaskWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white.withOpacity(.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Today Reminder",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Title",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${DateFormat("hh:mm a").format(DateTime.now())}",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const Icon(
            Icons.notifications,
            size: 70,
            color: Colors.yellow,
          )
        ],
      ),
    );
  }

  _taskListWidget() {
    return Obx(() => Expanded(
          child: ListView.builder(
            itemCount: taskController.task.length,
            itemBuilder: (_, index) {
              return _taskListItem(taskController.task[index]);
            },
          ),
        ));
  }

  _taskListItem(TaskEntity task) {
    return Slidable(
      controller: _slidableController,
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      enabled: true,
      closeOnScroll: true,
      secondaryActions: [
        GestureDetector(
          onTap: () {},
          child: FittedBox(
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.delete,
                    size: 16,
                    color: Colors.white,
                  ),
                  Text(
                    "Delete",
                    style: TextStyle(fontSize: 7, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        )
      ],
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            AwesomeDialog(
              context: context,
              borderSide: BorderSide(color: taskTypeListColor[0], width: 2),
              width: 280,
              buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
              headerAnimationLoop: true,
              animType: AnimType.TOPSLIDE,
              title: 'title',
              desc: 'title\n${DateFormat("hh:mm a").format(DateTime.now())}',
              showCloseIcon: false,
              dialogType: DialogType.INFO,
              btnOkOnPress: () {},
            ).show();
          },
          child: Card(
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                    height: 60,
                    width: 4,
                    decoration: BoxDecoration(
                        color: taskTypeListColor[0],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: true == false ? Colors.white : Colors.green,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          border: Border.all(color: Colors.grey.shade400)),
                      child: true == false
                          ? const Icon(
                              Icons.done,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${DateFormat("hh:mm a").format(DateTime.now())}",
                    style: TextStyle(color: Colors.black.withOpacity(.4)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.1,
                      child: Text(
                        task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            decoration: true == false
                                ? TextDecoration.none
                                : TextDecoration.lineThrough),
                      )),
                ]),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.notifications,
                      color: true == false ? Colors.grey : Colors.deepOrange,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
