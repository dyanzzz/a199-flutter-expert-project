import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/domain/usecases/get_popular_movies.dart';
import 'package:top_rated/domain/usecases/get_top_rated_movies.dart';

part 'core_event.dart';
part 'core_state.dart';

class CoreMovieBloc extends Bloc<CoreEvent, CoreState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  CoreMovieBloc(
    this._getNowPlayingMovies,
    this._getPopularMovies,
    this._getTopRatedMovies,
  ) : super(CoreEmpty()) {
    on<OnQueryChangedCore>(
      (event, emit) async {
        emit(CoreLoading());

        final result = await _getNowPlayingMovies.execute();
        final popular = await _getPopularMovies.execute();
        final topRated = await _getTopRatedMovies.execute();

        late List<Movie> listResult;
        late List<Movie> listPopular;
        late List<Movie> listTopRated;

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

        emit(CoreMovieHasData(
          listResult,
          listPopular,
          listTopRated,
        ));
      },
    );
  }
}
