part of 'watchlist_movie_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends WatchlistEvent {
  const OnQueryChanged();

  @override
  List<Object> get props => [];
}
