import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation/recommendation.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailMovieBloc extends Bloc<DetailEvent, DetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetWatchListStatus _getWatchListStatus;
  final GetMovieRecommendations _recommendationsMovies;

  DetailMovieBloc(
    this._getMovieDetail,
    this._getWatchListStatus,
    this._recommendationsMovies,
  ) : super(DetailEmpty()) {
    on<OnQueryChangedDetail>(
      (event, emit) async {
        final id = event.id;

        emit(DetailLoading());

        final result = await _getMovieDetail.execute(id);
        final resultStatusWatchlist = await _getWatchListStatus.execute(id);
        final resultRecommendationsMovies =
            await _recommendationsMovies.execute(id);

        late MovieDetail dataDetail;
        late List<Movie> recommendationMovies;

        result.fold(
          (failure) {
            emit(DetailError(failure.message));
          },
          (data) {
            dataDetail = data;
          },
        );

        resultRecommendationsMovies.fold(
          (failure) {
            emit(DetailError(failure.message));
          },
          (recommendation) {
            recommendationMovies = recommendation;
          },
        );

        emit(
          DetailMovieHasData(
            dataDetail,
            resultStatusWatchlist,
            recommendationMovies,
          ),
        );
      },
    );
  }
}
