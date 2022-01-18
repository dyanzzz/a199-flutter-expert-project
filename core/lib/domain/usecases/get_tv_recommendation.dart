import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvRecommendation {
  final TvRepository repository;

  GetTvRecommendation(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getRecommendationTvShow(id);
  }
}
