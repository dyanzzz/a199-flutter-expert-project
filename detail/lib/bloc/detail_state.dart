part of 'detail_movie_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends DetailState {}

class DetailLoading extends DetailState {}

class DetailError extends DetailState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailMovieHasData extends DetailState {
  final MovieDetail result;
  final bool getWatchListStatus;
  final List<Movie> getMovieRecommendations;

  const DetailMovieHasData(
    this.result,
    this.getWatchListStatus,
    this.getMovieRecommendations,
  );

  @override
  List<Object> get props => [
        result,
        getWatchListStatus,
        getMovieRecommendations,
      ];
}

class DetailTvHasData extends DetailState {
  final TvDetail result;
  final bool getWatchListStatus;
  final List<Tv> getTvRecommendations;

  const DetailTvHasData(
    this.result,
    this.getWatchListStatus,
    this.getTvRecommendations,
  );

  @override
  List<Object> get props => [
        result,
        getWatchListStatus,
        getTvRecommendations,
      ];
}

// new
/* class AddWatchlistMovieData extends DetailState {
  final String movie;

  const AddWatchlistMovieData(this.movie);

  @override
  List<Object> get props => [movie];
}

/* class RemoveWatchlistMovieData extends DetailState {
  final String movie;

  const RemoveWatchlistMovieData(this.movie);

  @override
  List<Object> get props => [movie];
} */

class GetWatchlistStatusMovieData extends DetailState {
  final bool movie;

  const GetWatchlistStatusMovieData(this.movie);

  @override
  List<Object> get props => [movie];
}
 */