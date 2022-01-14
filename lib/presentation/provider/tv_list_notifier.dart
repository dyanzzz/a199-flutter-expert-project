import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirTvShows = <Tv>[];
  List<Tv> get onTheAirTvShows => _onTheAirTvShows;

  RequestState _onTheAirTvShowsState = RequestState.Empty;
  RequestState get onTheAirTvShowsState => _onTheAirTvShowsState;

  var _popularTvShows = <Tv>[];
  List<Tv> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.Empty;
  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <Tv>[];
  List<Tv> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.Empty;
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
    _onTheAirTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();
    result.fold(
      (failure) {
        _onTheAirTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirTvShowsState = RequestState.Loaded;
        _onTheAirTvShows = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvPopular() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvShowsState = RequestState.Loaded;
        _popularTvShows = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvTopRated() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvShowsState = RequestState.Loaded;
        _topRatedTvShows = tvData;
        notifyListeners();
      },
    );
  }
}
