import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/popular.dart';

class PopularTvBloc extends Bloc<PopularEvent, PopularState> {
  final GetTvPopular _popularTvShow;

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
    );
  }
}
