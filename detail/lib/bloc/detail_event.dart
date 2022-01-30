part of 'detail_movie_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedDetail extends DetailEvent {
  final int id;

  const OnQueryChangedDetail(this.id);

  @override
  List<Object> get props => [id];
}
