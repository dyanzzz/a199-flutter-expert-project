import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTvShow();
  Future<Either<Failure, List<Tv>>> getPopularTvShow();
  Future<Either<Failure, List<Tv>>> getTopRatedTvShow();
  Future<Either<Failure, TvDetail>> getDetailTvShow(int id);
  Future<Either<Failure, List<Tv>>> getRecommendationTvShow(int id);
  Future<Either<Failure, List<Tv>>> searchTvShow(String query);
  Future<Either<Failure, String>> saveWatchList(TvDetail tv);
  Future<Either<Failure, String>> removeWatchList(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchList();
}
