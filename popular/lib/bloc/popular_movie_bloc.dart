import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular/popular.dart';
import 'package:rxdart/rxdart.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularMovieBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMovies _popularMovies;

  PopularMovieBloc(this._popularMovies) : super(PopularEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        emit(PopularLoading());

        final result = await _popularMovies.execute();

        result.fold(
          (failure) {
            emit(PopularError(failure.message));
          },
          (data) {
            emit(PopularMovieHasData(data));
          },
        );
      },
    );
  }
}
