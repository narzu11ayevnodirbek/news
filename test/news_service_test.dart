import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mock_news_service.mocks.dart';

void main() {
  group('NewsService Test', () {
    late MockNewsService mockNewsService;

    setUp(() {
      mockNewsService = MockNewsService();
    });

    test('fetchNews returns a list of news', () async {
      // Given
      when(mockNewsService.fetchTopHeadlines()).thenAnswer((_) async => []);

      // When
      final news = await mockNewsService.fetchTopHeadlines();

      // Then
      expect(news.length, 2);
      expect(news[0], 'News1');
    });
  });
}
