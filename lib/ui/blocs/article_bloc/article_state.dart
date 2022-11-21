part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
}

class ArticleInitial extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoading extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleSuccess extends ArticleState {
  final ArticleResponse articleResponse;

  const ArticleSuccess(this.articleResponse);

  @override
  List<Object> get props => [articleResponse];
}

class ArticleFailed extends ArticleState {
  final String errorMessage;

  const ArticleFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
