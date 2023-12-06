// ignore_for_file: avoid_print, constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart';
import '../models/article_models.dart';
import '../models/error_models.dart';
import '../models/source_models.dart';

const String BASE_URL = "https://newsapi.org/v2/";

class NewsAPI {
  final String apiKey;

  NewsAPI(this.apiKey);

  Future<dynamic> _call(String url, String key) async {
    url = "$url&apiKey=$apiKey";
    print(url);
    try {
      var response = await get(Uri.parse(url));
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson["status"].toString().toLowerCase() == "ok") {
        return responseJson[key];
      }
      return Future.error(
        ApiError(
          responseJson["code"],
          responseJson["message"],
        ),
      );
    } catch (e) {
      return Future.error(ApiError("unknown", e.toString()));
    }
  }

  Future<List<Source>> getSources({
    String? category,
    String? language,
    String? country,
  }) async {
    String url = "${BASE_URL}sources?x=y";
    if (category != null) {
      url = "$url&category=${category.toString().split(".").last}";
    }
    if (language != null) {
      url =
          "$url&language=${language.toString().toLowerCase().split(".").last}";
    }
    if (country != null) {
      url = "$url&country=${country.toString().toLowerCase().split(".").last}";
    }
    return Source.parseList(await (_call(
      url,
      "sources",
    )));
  }

  Future<List<Article>> getEverything({
    String? query,
    String? queryInTitle,
    String? sources,
    String? domains,
    String? excludeDomains,
    DateTime? from,
    DateTime? to,
    String? language,
    String? sortBy,
    int? pageSize,
    int? page,
  }) async {
    String url = "${BASE_URL}everything?x=y";
    if (query != null) url = "$url&q=$query";
    if (queryInTitle != null) url = "$url&qInTitle=$queryInTitle";
    if (sources != null) url = "$url&sources=$sources";
    if (domains != null) url = "$url&domains=$domains";
    if (excludeDomains != null) url = "$url&excludeDomains=$excludeDomains";
    if (from != null) url = "$url&from=${_formatDate(from)}";
    if (to != null) url = "$url&to=${_formatDate(to)}";
    if (language != null) url = "$language&q=$language";
    if (sortBy != null) url = "$sortBy&q=$sortBy";
    if (pageSize != null) url = "$url&pageSize=$pageSize";
    if (page != null) url = "$url&page=$page";
    return Article.parseList(await (_call(
      url,
      "articles",
    )));
  }

  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
    int? pageSize,
    int? page,
  }) async {
    String url = "${BASE_URL}top-headlines?x=y";
    if (country != null) url = "$url&country=$country";
    if (category != null) url = "$url&category=$category";
    if (sources != null) url = "$url&sources=$sources";
    if (query != null) url = "$url&q=$query";
    if (pageSize != null) url = "$url&pageSize=$pageSize";
    if (page != null) url = "$url&page=$page";
    return Article.parseList(await (_call(
      url,
      "articles",
    )));
  }

  String _formatDate(DateTime dt) {
    return "${dt.year}-${dt.month}-${dt.day}T${dt.hour}:${dt.minute}:${dt.second}";
  }
}
