import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_pages.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.indigoAccent),
      initialRoute: AppPages.initial,
    );
  }
}
