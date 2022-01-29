/* import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/watchlist.dart';

class TvWatchlistNotifier extends ChangeNotifier {
  var _tvWatchlist = <Tv>[];
  List<Tv> get tvWatchlist => _tvWatchlist;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  TvWatchlistNotifier({required this.getTvWatchlist});

  final GetTvWatchlist getTvWatchlist;

  Future<void> fetchTvWatchlist() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getTvWatchlist.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.loaded;
        _tvWatchlist = tvData;
        notifyListeners();
      },
    );
  }
}
 */