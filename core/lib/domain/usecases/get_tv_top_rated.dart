import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvTopRated {
  final TvRepository repository;

  GetTvTopRated(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvShow();
  }
}
