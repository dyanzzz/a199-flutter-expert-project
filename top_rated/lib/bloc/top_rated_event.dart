part of 'top_rated_movie_bloc.dart';

abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends TopRatedEvent {
  const OnQueryChanged();

  @override
  List<Object> get props => [];
}
