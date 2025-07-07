import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/core/network/dio_client.dart';
import 'package:news/features/home/data/models/news_model.dart';
import 'package:news/features/home/data/repositories/news_repository_impl.dart';
import 'package:news/features/home/data/services/news_service.dart';
import 'package:news/features/home/domain/usecases/get_news_usecase.dart';

// Service Provider
final dioProvider = Provider((ref) => DioClient.createDio());
final newsServiceProvider = Provider(
  (ref) => NewsService(ref.read(dioProvider)),
);

// Repository Provider
final newsRepositoryProvider = Provider(
  (ref) => NewsRepositoryImpl(ref.read(newsServiceProvider)),
);

// UseCase Provider
final getNewsUseCaseProvider = Provider(
  (ref) => GetNewsUseCase(ref.read(newsRepositoryProvider)),
);

// StateNotifierProvider or FutureProvider
final newsListProvider = FutureProvider.family<List<NewsModel>, String?>((
  ref,
  category,
) async {
  final usecase = ref.read(getNewsUseCaseProvider);
  return usecase(category: category);
});
