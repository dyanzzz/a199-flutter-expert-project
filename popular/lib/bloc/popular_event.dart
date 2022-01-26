part of 'popular_movie_bloc.dart';

abstract class PopularEvent extends Equatable {
  const PopularEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends PopularEvent {
  const OnQueryChanged();

  @override
  List<Object> get props => [];
}
