import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  final GetTvTopRated getTvTopRated;

  TvTopRatedNotifier({required this.getTvTopRated});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvTopRated() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRated.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
