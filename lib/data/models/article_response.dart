// To parse this JSON data, do
//
//     final userLoginResponse = userLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:test_elisoft/data/models/user_login_response.dart';

ArticleResponse userLoginResponseFromJson(String str) => ArticleResponse.fromJson(json.decode(str));

String userLoginResponseToJson(ArticleResponse data) => json.encode(data.toJson());

class ArticleResponse {
  ArticleResponse({
    this.code,
    this.status,
    this.message,
    this.articles,
  });

  int? code;
  bool? status;
  String? message;
  List<Article>? articles;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "articles": List<dynamic>.from((articles ?? []).map((x) => x.toJson())),
  };
}

class Article {
  Article({
    this.uuid,
    this.title,
    this.content,
    this.image,
    this.views,
    this.created,
    this.user,
  });

  String? uuid;
  String? title;
  String? content;
  String? image;
  int? views;
  Created? created;
  User? user;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    uuid: json["uuid"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
    views: json["views"],
    created: Created.fromJson(json["created"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "title": title,
    "content": content,
    "image": image,
    "views": views,
    "created": created?.toJson(),
    "user": user?.toJson(),
  };
}
