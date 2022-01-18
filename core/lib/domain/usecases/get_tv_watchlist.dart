import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvWatchlist {
  final TvRepository _repository;

  GetTvWatchlist(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchList();
  }
}
