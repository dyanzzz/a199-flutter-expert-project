part of 'recommendation_movie_bloc.dart';

abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends RecommendationEvent {
  final int id;

  const OnQueryChanged(this.id);

  @override
  List<Object> get props => [id];
}
