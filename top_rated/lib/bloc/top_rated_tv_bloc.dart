import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:top_rated/top_rated.dart';

class TopRatedTvBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTvTopRated _topRatedTv;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  TopRatedTvBloc(this._topRatedTv) : super(TopRatedEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        emit(TopRatedLoading());

        final result = await _topRatedTv.execute();

        result.fold(
          (failure) {
            emit(TopRatedError(failure.message));
          },
          (data) {
            emit(TopRatedTvHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
