// ignore_for_file: unnecessary_overrides

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/api/remote_service.dart';
import '../../../data/models/article_models.dart';

class HomeController extends GetxController {
  late RxList<Article> newsArticles;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    newsArticles = <Article>[].obs;
    getNewsData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getNewsData() async {
    try {
      isLoading(true);
      final newsAPI = NewsAPI("fdbf840272ef478ca1cda2f65c844b7f");
      newsArticles.value = await newsAPI.getTopHeadlines(
        country: "us",
        category: "GENERAL",
        pageSize: 10,
      );
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
