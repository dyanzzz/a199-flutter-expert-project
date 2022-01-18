import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvPopular {
  final TvRepository repository;

  GetTvPopular(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTvShow();
  }
}
