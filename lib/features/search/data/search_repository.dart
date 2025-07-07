import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/features/home/data/models/news_model.dart';

final searchRepositoryProvider = Provider((ref) => SearchRepository());

class SearchRepository {
  final dio = Dio();

  Future<List<NewsModel>> searchNews(String query) async {
    final response = await dio.get(
      'https://newsapi.org/v2/everything',
      queryParameters: {
        'q': query,
        'apiKey': 'e42c944709344b63985e0f5c115d5014',
      },
    );
    final List articles = response.data['articles'];
    return articles.map((e) => NewsModel.fromJson(e)).toList();
  }
}
