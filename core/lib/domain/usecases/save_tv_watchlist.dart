import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SaveTvWatchlist {
  final TvRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchList(tv);
  }
}
