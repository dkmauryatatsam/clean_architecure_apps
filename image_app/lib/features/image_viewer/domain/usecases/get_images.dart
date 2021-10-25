import 'package:dartz/dartz.dart';
import 'package:image_app/core/error/failure.dart';
import 'package:image_app/features/image_viewer/domain/entities/image_intity.dart';
import 'package:image_app/features/image_viewer/domain/repositories/image_repository.dart';

class GetImages {
  final ImageRepository imageRepository;
  GetImages({
    required this.imageRepository,
  });

  Future<Either<Failure, List<ImageEntity>>> call() {
    return imageRepository.getImage();
  }
}
