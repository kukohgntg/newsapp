// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api/remote_service.dart';
import '../../../data/models/article_models.dart';

class DiscoverController extends GetxController {
  late RxList<Article> articles;

  RxString searchTerm = ''.obs;

  var isSearching = false.obs;

  TextEditingController searchController = TextEditingController();

  var categoryItems = [
    "GENERAL",
    "BUSINESS",
    "ENTERTAINMENT",
    "HEALTH",
    "SCIENCE",
    "SPORTS",
    "TECHNOLOGY",
  ];

  RxString selectedCategory = "GENERAL".obs;

  @override
  void onInit() {
    super.onInit();
    articles = <Article>[].obs;
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
    final newsAPI = NewsAPI("fdbf840272ef478ca1cda2f65c844b7f");
    articles.value = await newsAPI.getTopHeadlines(
      country: "us",
      query: searchTerm.value,
      category: selectedCategory.value,
      pageSize: 20,
    );
  }

  void setSearchTerm(String term) {
    searchTerm.value = term;
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    getNewsData();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchTerm.value = '';
      searchController.text = '';
      getNewsData();
    }
  }
}
