import 'package:dio/dio.dart';
import '../models/news_model.dart';

class NewsService {
  final Dio _dio;

  NewsService(this._dio);

  Future<List<NewsModel>> fetchTopHeadlines({
    String country = 'us',
    String? category,
  }) async {
    const apiKey = 'e42c944709344b63985e0f5c115d5014';
    final url = 'https://newsapi.org/v2/top-headlines';

    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          'apiKey': apiKey,
          'country': country,
          if (category != null) 'category': category,
        },
      );

      if (response.statusCode == 200) {
        final articles = response.data['articles'] as List;
        return articles.map((json) => NewsModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Dio error: $e');
    }
  }
}
