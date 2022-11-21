part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class FetchArticleEvent extends ArticleEvent{
  @override
  List<Object?> get props => [

  ];

}