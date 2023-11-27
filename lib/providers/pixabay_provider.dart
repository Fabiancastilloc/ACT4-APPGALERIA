import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:galeria_reales/models/image_model.dart';
import 'package:galeria_reales/models/video_model.dart';

class PixabayProvider {
  final String apiKey = '';
  final String baseUrl = 'https://pixabay.com/api/';

  Future<List<ImageModel>> getImages(String query) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hits'] as List).map((e) => ImageModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<List<VideoModel>> getVideos(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/videos/?key=$apiKey&q=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hits'] as List).map((e) => VideoModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
