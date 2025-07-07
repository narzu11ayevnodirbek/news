import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/features/home/data/models/news_model.dart';

class BookmarkNotifier extends StateNotifier<List<NewsModel>> {
  BookmarkNotifier() : super([]);

  void toggleBookmark(NewsModel news) {
    if (state.contains(news)) {
      state = state.where((item) => item != news).toList();
    } else {
      state = [...state, news];
    }
  }

  bool isBookmarked(NewsModel news) {
    return state.contains(news);
  }
}

final bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, List<NewsModel>>((ref) {
      return BookmarkNotifier();
    });
