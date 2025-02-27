import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:rxdart/rxdart.dart';

class SearchTvBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTv _searchTv;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchTvBloc(this._searchTv) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        print(query);

        emit(SearchLoading());

        final result = await _searchTv.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchTvHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
