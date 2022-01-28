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

// new
/* class AddWatchlist extends DetailEvent {
  final MovieDetail movieDetail;
  final String type;

  const AddWatchlist(this.movieDetail, this.type);

  @override
  List<Object> get props => [movieDetail, type];
}

/* class DeleteWatchlist extends DetailEvent {
  final MovieDetail movieDetail;

  const DeleteWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
} */

class GetWatchlistStatus extends DetailEvent {
  final int id;

  const GetWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
 */