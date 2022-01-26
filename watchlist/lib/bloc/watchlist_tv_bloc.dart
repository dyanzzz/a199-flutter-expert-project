import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:watchlist/domain/usecases/get_tv_watchlist.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistTvBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetTvWatchlist _watchlistTv;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  WatchlistTvBloc(this._watchlistTv) : super(WatchlistEmpty()) {
    on<OnQueryChanged>(
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
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
