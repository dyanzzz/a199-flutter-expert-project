part of 'top_rated_movie_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedEmpty extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedError extends TopRatedState {
  final String message;

  const TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMovieHasData extends TopRatedState {
  final List<Movie> result;

  const TopRatedMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvHasData extends TopRatedState {
  final List<Tv> result;

  const TopRatedTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
