import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:test_elisoft/data/models/article_response.dart';

import '../../../core/consts/urls.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial()) {
    on<FetchArticleEvent>((event, emit) async {
      emit(ArticleLoading());
      try{
        final response = await http.get(Uri.https(baseUrl,articleUrl),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 15), onTimeout: (){
          throw TimeoutException("Article Gagal");
        });

        print("response code: ${response.statusCode}");
        print("response body: ${response.body}");

        if(response.statusCode == 200){
          emit(ArticleSuccess(ArticleResponse.fromJson(jsonDecode(response.body))));
          return;
        }
        emit(ArticleFailed("Server Error (code: ${response.statusCode})"));
      } on TimeoutException {
        emit(const ArticleFailed("TimeOut"));
      }

    });
  }
}
