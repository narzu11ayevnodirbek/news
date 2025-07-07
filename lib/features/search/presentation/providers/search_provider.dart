import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/features/home/data/models/news_model.dart';
import 'package:news/features/search/data/search_repository.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchResultsProvider = FutureProvider.autoDispose<List<NewsModel>>((
  ref,
) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return [];
  }
  final repo = ref.read(searchRepositoryProvider);
  return repo.searchNews(query);
});
