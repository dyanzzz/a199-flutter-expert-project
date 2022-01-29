import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _watchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;
  late bool _watchlistStatus;
  bool get watchlistStatus => _watchlistStatus;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  static const actionAdd = 'add';
  static const actionRemove = 'remove';

  WatchlistMovieBloc(this._watchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistEmpty()) {
    on<OnQueryChangedDetailMovie>(
      (event, emit) async {
        emit(WatchlistLoading());

        final result = await _watchlistMovies.execute();

        result.fold(
          (failure) {
            emit(WatchlistError(failure.message));
          },
          (data) {
            emit(WatchlistMovieHasData(data));
          },
        );
      },
    );

    on<GetWatchlistStatus>(
      (event, emit) async {
        final id = event.id;

        final result = await _getWatchListStatus.execute(id);

        _watchlistStatus = result;
        emit(GetWatchlistStatusData(result));
      },
    );

    on<AddMovieWatchlist>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final type = event.type;

        final Either<Failure, String> result;
        if (type == actionAdd) {
          result = await _saveWatchlist.execute(movieDetail);
        } else {
          result = await _removeWatchlist.execute(movieDetail);
        }

        await result.fold(
          (failure) async {
            _watchlistMessage = failure.message;

            //emit(WatchlistError(failure.message));
          },
          (data) async {
            _watchlistMessage = data;

            emit(AddWatchlistData(data));
          },
        );

        add(GetWatchlistStatus(event.movieDetail.id));
      },
    );
  }
}
