import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation/domain/usecases/get_movie_recommendations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetMovieRecommendations _recommendationsMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  RecommendationMovieBloc(this._recommendationsMovies)
      : super(RecommendationEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final id = event.id;

        emit(RecommendationLoading());

        final result = await _recommendationsMovies.execute(id);

        result.fold(
          (failure) {
            emit(RecommendationError(failure.message));
          },
          (data) {
            emit(RecommendationMovieHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
