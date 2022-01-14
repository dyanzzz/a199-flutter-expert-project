import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:flutter/foundation.dart';

class TvWatchlistNotifier extends ChangeNotifier {
  var _tvWatchlist = <Tv>[];
  List<Tv> get tvWatchlist => _tvWatchlist;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  TvWatchlistNotifier({required this.getTvWatchlist});

  final GetTvWatchlist getTvWatchlist;

  Future<void> fetchTvWatchlist() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getTvWatchlist.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.Loaded;
        _tvWatchlist = tvData;
        notifyListeners();
      },
    );
  }
}
