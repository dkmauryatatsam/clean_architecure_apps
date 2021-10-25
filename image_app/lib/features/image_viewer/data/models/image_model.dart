import 'package:image_app/core/error/exception.dart';
import 'package:image_app/features/image_viewer/domain/entities/image_intity.dart';

class ImageModel {
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;
  ImageModel(
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  );

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      json['id'],
      json['title'],
      json['url'],
      json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "title": title,
      "url": url,
      "thumbnailUrl": thumbnailUrl,
    };
  }

  ImageEntity toDomain() {
    checkIfNull(title);
    checkIfNull(url);
    checkIfNull(thumbnailUrl);
    return ImageEntity(title: title!, url: url!, thumbnailUrl: thumbnailUrl!);
  }

  factory ImageModel.fromDomain(ImageEntity domain) {
    return ImageModel(null, domain.title, domain.url, domain.thumbnailUrl);
  }
}

checkIfNull(dynamic field) {
  if (field == null) {
    throw DataToDomainConversionException();
  }
}
