import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:flutter/cupertino.dart';

class TvPopularNotifier extends ChangeNotifier {
  final GetTvPopular getTvPopular;

  TvPopularNotifier(this.getTvPopular);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvPopular() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();

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
