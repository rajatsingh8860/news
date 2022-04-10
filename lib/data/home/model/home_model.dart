import 'package:freezed_annotation/freezed_annotation.dart';

class NewsModel {
  String? author;
  String? title;
  String? newsSource;
  String? description;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
  NewsModel(
      {
      @Default('') this.author,
      @Default('') this.title,
      @Default('') this.newsSource,
      @Default('') this.description,
      @Default('') this.urlToImage,
      @Default('') this.publishedAt,
      @Default('') this.content});
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'] as String,
      title: json['title'] as String,
      newsSource : json['newsSource'] as String,
      description: json['description'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] ,
      content: json['content'] as String,
    );
  }
}
