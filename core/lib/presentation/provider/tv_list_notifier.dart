import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirTvShows = <Tv>[];
  List<Tv> get onTheAirTvShows => _onTheAirTvShows;

  RequestState _onTheAirTvShowsState = RequestState.empty;
  RequestState get onTheAirTvShowsState => _onTheAirTvShowsState;

  var _popularTvShows = <Tv>[];
  List<Tv> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.empty;
  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <Tv>[];
  List<Tv> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.empty;
  RequestState get topRatedTvShowState => _topRatedTvShowsState;

  String _message = '';
  String get message => _message;

  final GetTvOnTheAir getTvOnTheAir;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvTopRated;

  TvListNotifier({
    required this.getTvOnTheAir,
    required this.getTvPopular,
    required this.getTvTopRated,
  });

  Future<void> fetchTvOnTheAir() async {
    _onTheAirTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();
    result.fold(
      (failure) {
        _onTheAirTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirTvShowsState = RequestState.loaded;
        _onTheAirTvShows = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvPopular() async {
    _popularTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvShowsState = RequestState.loaded;
        _popularTvShows = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvTopRated() async {
    _topRatedTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvShowsState = RequestState.loaded;
        _topRatedTvShows = tvData;
        notifyListeners();
      },
    );
  }
}
