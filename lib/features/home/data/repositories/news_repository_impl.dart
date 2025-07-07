import 'package:news/features/home/data/models/news_model.dart';
import 'package:news/features/home/data/services/news_service.dart';
import 'package:news/features/home/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsService newsService;

  NewsRepositoryImpl(this.newsService);

  @override
  Future<List<NewsModel>> getTopHeadlines({
    String country = 'us',
    String? category,
  }) {
    return newsService.fetchTopHeadlines(country: country, category: category);
  }
}
