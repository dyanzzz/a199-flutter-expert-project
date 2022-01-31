import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation/recommendation.dart';
import 'package:watchlist/watchlist.dart';

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

        result.fold(
          (failure) {
            emit(DetailError(failure.message));
          },
          (data) {
            resultRecommendationsTv.fold(
              (failure) {
                emit(DetailError(failure.message));
              },
              (recommendation) {
                emit(DetailTvHasData(
                  data,
                  resultStatusWatchlist,
                  recommendation,
                ));
              },
            );
          },
        );
      },
    );
  }
}
