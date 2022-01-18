import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShow(query);
  }
}
