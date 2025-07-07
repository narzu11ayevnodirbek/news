import '../../data/models/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getTopHeadlines({String country, String? category});
}
