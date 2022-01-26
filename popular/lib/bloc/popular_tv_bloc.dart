import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/popular.dart';
import 'package:rxdart/rxdart.dart';

class PopularTvBloc extends Bloc<PopularEvent, PopularState> {
  final GetTvPopular _popularTvShow;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  PopularTvBloc(this._popularTvShow) : super(PopularEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        emit(PopularLoading());

        final result = await _popularTvShow.execute();

        result.fold(
          (failure) {
            emit(PopularError(failure.message));
          },
          (data) {
            emit(PopularTvHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
