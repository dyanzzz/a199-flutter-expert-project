part of 'watchlist_movie_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedDetailMovie extends WatchlistEvent {
  const OnQueryChangedDetailMovie();

  @override
  List<Object> get props => [];
}

class OnQueryChangedDetailTv extends WatchlistEvent {
  const OnQueryChangedDetailTv();

  @override
  List<Object> get props => [];
}

class AddMovieWatchlist extends WatchlistEvent {
  final MovieDetail movieDetail;
  final String type;

  const AddMovieWatchlist(this.movieDetail, this.type);

  @override
  List<Object> get props => [movieDetail, type];
}

class AddTvWatchlist extends WatchlistEvent {
  final TvDetail tvDetail;
  final String type;

  const AddTvWatchlist(this.tvDetail, this.type);

  @override
  List<Object> get props => [tvDetail, type];
}

class GetWatchlistStatus extends WatchlistEvent {
  final int id;

  const GetWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
