import '../../data/models/news_model.dart';
import '../repositories/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<List<NewsModel>> call({String country = 'us', String? category}) {
    return repository.getTopHeadlines(country: country, category: category);
  }
}
