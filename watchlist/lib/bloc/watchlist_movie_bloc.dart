import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _watchlistMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  WatchlistMovieBloc(this._watchlistMovies) : super(WatchlistEmpty()) {
    on<OnQueryChanged>(
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
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
