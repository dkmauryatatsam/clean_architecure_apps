import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:daily_task/core/app_const.dart';
import 'package:daily_task/features/dailyTask/presentation/pages/complete_task_page.dart';
import 'package:daily_task/features/dailyTask/presentation/pages/home_page.dart';
import 'package:daily_task/features/dailyTask/presentation/widgets/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> get _pages => [const HomePage(), const CompleteTaskPage()];
  final iconList = <IconData>[Icons.home, Icons.list];
  int pageNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorC80863,
        elevation: 8,
        onPressed: () {
          Get.toNamed('/addNewTask');
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: _bottomnavBar(),
      body: _pages[pageNavIndex],
    );
  }

  Widget _bottomnavBar() {
    return AnimatedBottomNavigationBar(
        activeColor: color6FADE4,
        gapLocation: GapLocation.center,
        icons: iconList,
        activeIndex: pageNavIndex,
        onTap: (index) {
          setState(() {
            pageNavIndex = index;
          });
        });
  }
}
