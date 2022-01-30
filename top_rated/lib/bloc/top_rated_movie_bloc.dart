import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_rated/top_rated.dart';
import 'package:rxdart/rxdart.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies _topRatedMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  TopRatedMovieBloc(this._topRatedMovies) : super(TopRatedEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        emit(TopRatedLoading());

        final result = await _topRatedMovies.execute();

        result.fold(
          (failure) {
            emit(TopRatedError(failure.message));
          },
          (data) {
            emit(TopRatedMovieHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
