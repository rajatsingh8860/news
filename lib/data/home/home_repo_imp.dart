import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news/data/home/model/home_model.dart';
import 'package:news/domain/home/home_repo.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: HomeRepo)
class HomeRepoImplementation extends HomeRepo {
  @override
  Future<Either<String, List<NewsModel>>> getNewsFeed(
      {String? country,
      bool? isPullToRefresh,
      String? sortUsing,
      bool? sort,
      String categoryName = "technology",
      int? page}) async {
    try {
      String key = "9aa7b11c33124191a9c4b73fc9213d9f";

      String url =
          "https://newsapi.org/v2/top-headlines?country=$country&category=$categoryName&pageSize=6&page=$page&apiKey=$key";

      Uri uri = Uri.parse(url);
      var response = await http.get(uri);

      List<NewsModel> news = [];

      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        jsonData["articles"].forEach((element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            NewsModel article = NewsModel(
              title: element['title'],
              author: element['url'],
              newsSource: element['source']['name'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publishedAt: DateTime.parse(element['publishedAt']),
              content: element["content"],
            );
            news.add(article);
          }
        });
        return right(news);
      }
      return left("Unexpected error");
    } catch (e) {
      return left(e.toString());
    }
  }
}
