import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/app/data/api/remote_service.dart';
import 'package:newsapp/app/data/models/article_models.dart';

import 'api_service_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
// Constants for API details
  const String baseUrl = 'https://newsapi.org/v2/';
  const String topHeadlines = 'top-headlines?x=y';
  const String apiKey = 'fdbf840272ef478ca1cda2f65c844b7f';
  const String country = "us";
  const String category = "GENERAL";
  // const int pageSize = 5;

  // Initialize ApiService and MockClient
  late NewsAPI httpController;
  late MockClient mockClient;

  setUp(() {
    // Set up MockClient and ApiService for each test
    mockClient = MockClient();
    httpController = NewsAPI(apiKey);
  });

  group('ApiService', () {
    test('fetchArticles returns a list of articles if response is successful',
        () async {
      // Mock the HTTP response for successful case
      when(mockClient.get(Uri.parse(
              '$baseUrl$topHeadlines&country=$country&category=$category&apiKey=$apiKey')))
          .thenAnswer((_) async => http.Response(
              '{'
              '"status": "ok", '
              '"totalResults": 5, '
              '"articles": [], '
              '}',
              200)); // Mock the HTTP response

      final articles = await httpController.getTopHeadlines(
        country: "us",
        category: "GENERAL",
        pageSize: 5,
      );

      // Expect the fetched data to be a list of Article objects
      expect(articles, isA<List<Article>>());
    });

    test('fetchArticles returns an empty list if response fails', () async {
      // Mock the HTTP response for response failure
      when(mockClient.get(Uri.parse(
              '$baseUrl$topHeadlines&country=$country&category=$category&apiKey=$apiKey')))
          .thenAnswer((_) async =>
              http.Response('Server error', 500)); // Mock the HTTP response

      final articles = await httpController.getTopHeadlines(
        country: "us",
        category: "GENERAL",
        pageSize: 5,
      );

      // Expect the fetched data to be an empty list
      expect(articles, isA<List<Article>>());
    });

    test('fetchArticles returns an empty list if an error occurs', () async {
      // Mock an error response
      when(mockClient.get(Uri.parse(
              '$baseUrl$topHeadlines&country=$country&category=$category&apiKey=$apiKey')))
          .thenThrow(Exception('Test error')); // Mock an error

      final articles = await httpController.getTopHeadlines(
        country: "us",
        category: "GENERAL",
        pageSize: 5,
      );

      // Expect the fetched data to be an empty list
      expect(articles, isA<List<Article>>());
    });
  });
}
