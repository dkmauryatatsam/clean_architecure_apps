import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/di.dart';

import 'features/image_viewer/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitilaBinding(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
