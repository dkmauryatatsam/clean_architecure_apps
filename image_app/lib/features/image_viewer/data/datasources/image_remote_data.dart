import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:image_app/core/error/exception.dart';

import 'package:image_app/features/image_viewer/data/models/image_model.dart';

const String url = "https://jsonplaceholder.typicode.com/photos";

abstract class ImageRemoteData {
  Future<List<ImageModel>> getImages();
}

class ImageRemoteDataImpl implements ImageRemoteData {
  final http.Client client;
  ImageRemoteDataImpl({
    required this.client,
  });
  @override
  Future<List<ImageModel>> getImages() async {
    try {
      final uri = Uri.parse(url);
      final response = await client.get(uri);
      final jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse
          .map((image) => ImageModel.fromJson(image as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }
}
