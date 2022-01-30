import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/popular.dart';
import 'package:top_rated/top_rated.dart';

class CoreTvBloc extends Bloc<CoreEvent, CoreState> {
  final GetTvOnTheAir _getTvOnTheAir;
  final GetTvPopular _getTvPopular;
  final GetTvTopRated _getTvTopRated;

  CoreTvBloc(
    this._getTvOnTheAir,
    this._getTvPopular,
    this._getTvTopRated,
  ) : super(CoreEmpty()) {
    on<OnQueryChangedCore>(
      (event, emit) async {
        emit(CoreLoading());

        final result = await _getTvOnTheAir.execute();
        final popular = await _getTvPopular.execute();
        final topRated = await _getTvTopRated.execute();

        late List<Tv> listResult;
        late List<Tv> listPopular;
        late List<Tv> listTopRated;

        result.fold(
          (failure) {
            listResult = [];
            emit(CoreError(failure.message));
          },
          (data) {
            listResult = data;
          },
        );

        popular.fold(
          (failure) {
            listPopular = [];
            emit(CoreError(failure.message));
          },
          (data) {
            listPopular = data;
          },
        );

        topRated.fold(
          (failure) {
            listTopRated = [];
            emit(CoreError(failure.message));
          },
          (data) {
            listTopRated = data;
          },
        );

        emit(CoreTvHasData(
          listResult,
          listPopular,
          listTopRated,
        ));
      },
    );
  }
}
