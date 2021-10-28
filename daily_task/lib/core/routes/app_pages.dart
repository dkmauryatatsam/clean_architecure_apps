import 'package:daily_task/core/routes/app_route.dart';
import 'package:daily_task/features/dailyTask/presentation/binding/task_binding.dart';
import 'package:daily_task/features/dailyTask/presentation/pages/add_task_page.dart';
import 'package:daily_task/features/dailyTask/presentation/screens/home_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const initial = Routes.homeScreen;
  static final routes = [
    GetPage(
      page: () => const HomeScreen(),
      name: Routes.homeScreen,
      binding: TaskBinding(),
    ),
    GetPage(
      page: () => const AddTaskPage(),
      name: Routes.addNewTask,
      binding: TaskBinding(),
    ),
  ];
}
