import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/features/image_viewer/presentation/controller/image_controller.dart';

class HomePage extends GetView<ImageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Image",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        switch (controller.pageState()) {
          case PageState.initial:
            return const Center(
              child: Icon(Icons.search),
            );
          case PageState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case PageState.loaded:
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.images.length,
              itemBuilder: (_, index) {
                final imageData = controller.images[index];
                return Container(child: Image.network(imageData.url));
              },
            );
          case PageState.failed:
            return const Center(
                child: Icon(
              Icons.not_accessible,
            ));
        }
      }),
    );
  }
}
