import 'package:daily_task/features/dailyTask/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'injection_container.dart' as sl;

void main() async {
  await sl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
