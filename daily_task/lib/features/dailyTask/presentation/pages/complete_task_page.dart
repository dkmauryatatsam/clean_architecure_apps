import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:daily_task/features/dailyTask/presentation/widgets/common.dart';
import 'package:daily_task/features/dailyTask/presentation/widgets/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class CompleteTaskPage extends StatefulWidget {
  const CompleteTaskPage({Key? key}) : super(key: key);

  @override
  State<CompleteTaskPage> createState() => _CompleteTaskPageState();
}

class _CompleteTaskPageState extends State<CompleteTaskPage> {
  final SlidableController _slideController = SlidableController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      _header(),
      _taskListWidget(),
    ]));
  }

  _header() {
    return Container(
      height: 100,
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
                      "Complete Tasks",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "You have 5 complete task",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(.8),
                      ),
                    ),
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
        ],
      ),
    );
  }

  _taskListWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, index) {
          return _taskListItem();
        },
      ),
    );
  }

  _taskListItem() {
    return Slidable(
      controller: _slideController,
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
                      child: const Text(
                        "title",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            decoration: true == false
                                ? TextDecoration.none
                                : TextDecoration.lineThrough),
                      )),
                ]),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: const EdgeInsets.only(right: 12),
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
