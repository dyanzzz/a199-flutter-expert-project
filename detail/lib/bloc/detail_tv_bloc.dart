import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation/recommendation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:watchlist/watchlist.dart';

import 'detail_movie_bloc.dart';

class DetailTvBloc extends Bloc<DetailEvent, DetailState> {
  final GetTvDetail _getTvDetail;
  final GetTvWatchListStatus _getTvWatchListStatus;
  final GetTvRecommendation _getTvRecommendation;

  DetailTvBloc(
      this._getTvDetail, this._getTvWatchListStatus, this._getTvRecommendation)
      : super(DetailEmpty()) {
    on<OnQueryChangedDetail>(
      (event, emit) async {
        final id = event.id;

        emit(DetailLoading());

        final result = await _getTvDetail.execute(id);
        final resultStatusWatchlist = await _getTvWatchListStatus.execute(id);
        final resultRecommendationsTv = await _getTvRecommendation.execute(id);

        late TvDetail dataDetail;
        late List<Tv> recommendationTv;

        result.fold(
          (failure) {
            emit(DetailError(failure.message));
          },
          (data) {
            dataDetail = data;
          },
        );

        resultRecommendationsTv.fold(
          (failure) {
            emit(DetailError(failure.message));
          },
          (recommendation) {
            recommendationTv = recommendation;
          },
        );

        emit(DetailTvHasData(
          dataDetail,
          resultStatusWatchlist,
          recommendationTv,
        ));
      },
    );
  }
}
