/* import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_rated/top_rated.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  final GetTvTopRated getTvTopRated;

  TvTopRatedNotifier({required this.getTvTopRated});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvTopRated() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
 */