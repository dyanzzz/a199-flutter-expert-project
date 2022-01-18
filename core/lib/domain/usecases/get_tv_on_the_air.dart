import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvOnTheAir {
  final TvRepository repository;

  GetTvOnTheAir(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTvShow();
  }
}
