import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation/recommendation.dart';
import 'package:rxdart/rxdart.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetTvRecommendation _recommendationsTvShow;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  RecommendationTvBloc(this._recommendationsTvShow)
      : super(RecommendationEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final id = event.id;

        emit(RecommendationLoading());

        final result = await _recommendationsTvShow.execute(id);

        result.fold(
          (failure) {
            emit(RecommendationError(failure.message));
          },
          (data) {
            emit(RecommendationTvHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
