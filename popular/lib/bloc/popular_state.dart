part of 'popular_movie_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularEmpty extends PopularState {}

class PopularLoading extends PopularState {}

class PopularError extends PopularState {
  final String message;

  const PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMovieHasData extends PopularState {
  final List<Movie> result;

  const PopularMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class PopularTvHasData extends PopularState {
  final List<Tv> result;

  const PopularTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
