import 'package:get/state_manager.dart';
import 'package:image_app/features/image_viewer/domain/entities/image_intity.dart';

import 'package:image_app/features/image_viewer/domain/usecases/get_images.dart';

enum PageState { initial, loading, loaded, failed }

class ImageController extends GetxController {
  final GetImages getImages;
  ImageController({
    required this.getImages,
  });

  RxList<ImageEntity> images = RxList([]);
  var pageState = Rx<PageState>(PageState.initial);

  Future<void> fetchImage() async {
    pageState(PageState.loading);
    final imageData = await getImages();
    imageData.fold((l) => pageState(PageState.failed), (r) {
      images.value = r;
      pageState(PageState.loaded);
    });
  }

  @override
  void onInit() async {
    await fetchImage();
    super.onInit();
  }
}
