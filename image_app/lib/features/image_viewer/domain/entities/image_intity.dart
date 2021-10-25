class ImageEntity {
  String title;
  String url;
  String thumbnailUrl;
  ImageEntity({
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  @override
  String toString() =>
      'ImageEntity(title: $title, url: $url, thumbnailUrl: $thumbnailUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageEntity &&
        other.title == title &&
        other.url == url &&
        other.thumbnailUrl == thumbnailUrl;
  }

  @override
  int get hashCode => title.hashCode ^ url.hashCode ^ thumbnailUrl.hashCode;
}
