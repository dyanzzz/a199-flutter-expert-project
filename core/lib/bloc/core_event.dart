part of 'core_movie_bloc.dart';

abstract class CoreEvent extends Equatable {
  const CoreEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedCore extends CoreEvent {
  const OnQueryChangedCore();

  @override
  List<Object> get props => [];
}
