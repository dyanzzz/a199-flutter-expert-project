part of 'core_movie_bloc.dart';

abstract class CoreState extends Equatable {
  const CoreState();

  @override
  List<Object> get props => [];
}

class CoreEmpty extends CoreState {}

class CoreLoading extends CoreState {}

class CoreError extends CoreState {
  final String message;

  const CoreError(this.message);

  @override
  List<Object> get props => [message];
}

class CoreMovieHasData extends CoreState {
  final List<Movie> result;
  final List<Movie> popular;
  final List<Movie> topRated;

  const CoreMovieHasData(
    this.result,
    this.popular,
    this.topRated,
  );

  @override
  List<Object> get props => [
        result,
        popular,
        topRated,
      ];
}

class CoreTvHasData extends CoreState {
  final List<Tv> result;
  final List<Tv> popular;
  final List<Tv> topRated;

  const CoreTvHasData(
    this.result,
    this.popular,
    this.topRated,
  );

  @override
  List<Object> get props => [
        result,
        popular,
        topRated,
      ];
}
