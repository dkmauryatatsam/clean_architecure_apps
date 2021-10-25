import 'package:dartz/dartz.dart';
import 'package:image_app/core/error/exception.dart';
import 'package:image_app/core/error/failure.dart';
import 'package:image_app/features/image_viewer/data/datasources/image_remote_data.dart';
import 'package:image_app/features/image_viewer/domain/entities/image_intity.dart';
import 'package:image_app/features/image_viewer/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteData imageRemoteData;
  ImageRepositoryImpl({
    required this.imageRemoteData,
  });
  @override
  Future<Either<Failure, List<ImageEntity>>> getImage() async {
    try {
      final imageData = await imageRemoteData.getImages();
      final images = imageData.map((image) => image.toDomain()).toList();
      return right(images);
    } on ServerException {
      return left(ServerFailure());
    } on DataToDomainConversionException {
      return left(DataToDomainConversionFailure());
    }
  }
}
