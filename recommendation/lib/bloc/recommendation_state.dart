/* part of 'recommendation_movie_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

class RecommendationEmpty extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationError extends RecommendationState {
  final String message;

  const RecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationMovieHasData extends RecommendationState {
  final List<Movie> result;

  const RecommendationMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendationTvHasData extends RecommendationState {
  final List<Tv> result;

  const RecommendationTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
 */