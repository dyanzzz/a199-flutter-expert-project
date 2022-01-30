import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistTvBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetTvWatchlist _watchlistTv;
  final GetTvWatchListStatus _getTvWatchListStatus;
  final SaveTvWatchlist _saveTvWatchlist;
  final RemoveTvWatchlist _removeTvWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;
  late bool _watchlistStatus;
  bool get watchlistStatus => _watchlistStatus;

  WatchlistTvBloc(
    this._watchlistTv,
    this._getTvWatchListStatus,
    this._saveTvWatchlist,
    this._removeTvWatchlist,
  ) : super(WatchlistEmpty()) {
    on<OnQueryChangedWatchlistMovie>(
      (event, emit) async {
        emit(WatchlistLoading());

        final result = await _watchlistTv.execute();

        result.fold(
          (failure) {
            emit(WatchlistError(failure.message));
          },
          (data) {
            emit(WatchlistTvHasData(data));
          },
        );
      },
    );

    on<GetWatchlistStatus>(
      (event, emit) async {
        final id = event.id;

        final result = await _getTvWatchListStatus.execute(id);

        _watchlistStatus = result;
        emit(GetWatchlistStatusData(result));
      },
    );

    on<AddTvWatchlist>(
      (event, emit) async {
        final tvDetail = event.tvDetail;
        final type = event.type;

        final Either<Failure, String> result;
        if (type == actionAdd) {
          result = await _saveTvWatchlist.execute(tvDetail);
        } else {
          result = await _removeTvWatchlist.execute(tvDetail);
        }

        await result.fold(
          (failure) async {
            _watchlistMessage = failure.message;

            emit(WatchlistError(failure.message));
          },
          (data) async {
            _watchlistMessage = data;

            emit(AddWatchlistData(data));
          },
        );

        add(GetWatchlistStatus(event.tvDetail.id));
      },
    );
  }
}
