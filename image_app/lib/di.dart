import 'package:get/get.dart';
import 'package:image_app/features/image_viewer/data/datasources/image_remote_data.dart';
import 'package:image_app/features/image_viewer/data/repositories/image_repository_impl.dart';
import 'package:image_app/features/image_viewer/domain/repositories/image_repository.dart';
import 'package:image_app/features/image_viewer/domain/usecases/get_images.dart';
import 'package:http/http.dart' as http;
import 'package:image_app/features/image_viewer/presentation/controller/image_controller.dart';

class InitilaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageController(getImages: Get.find<GetImages>()));
    Get.lazyPut(() => GetImages(imageRepository: Get.find<ImageRepository>()),
        fenix: false);
    Get.lazyPut<ImageRepository>(
        () => ImageRepositoryImpl(imageRemoteData: Get.find<ImageRemoteData>()),
        fenix: false);
    Get.lazyPut<ImageRemoteData>(
        () => ImageRemoteDataImpl(client: Get.find<http.Client>()),
        fenix: false);
    Get.lazyPut<http.Client>(() => http.Client(), fenix: false);
  }
}
