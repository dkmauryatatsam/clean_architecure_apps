import 'package:dartz/dartz.dart';
import 'package:image_app/core/error/failure.dart';
import 'package:image_app/features/image_viewer/domain/entities/image_intity.dart';

abstract class ImageRepository {
  Future<Either<Failure, List<ImageEntity>>> getImage();
}
