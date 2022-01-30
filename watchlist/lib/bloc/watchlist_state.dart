part of 'watchlist_movie_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistState {
  final List<Movie> result;

  const WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvHasData extends WatchlistState {
  final List<Tv> result;

  const WatchlistTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class AddWatchlistData extends WatchlistState {
  final String message;

  const AddWatchlistData(this.message);

  @override
  List<Object> get props => [message];
}

class GetWatchlistStatusData extends WatchlistState {
  final bool status;

  const GetWatchlistStatusData(this.status);

  @override
  List<Object> get props => [status];
}
