import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final TvLocalDataSource localDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, TvDetail>> getDetailTvShow(int id) async {
    try {
      final result = await remoteDataSource.getTvShowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getOnTheAirTvShow() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOnTheAirTvShow();
        localDataSource.cacheOnTheAirTvShow(
            result.map((tv) => TvTable.fromDTO(tv)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCacheOnTheAirTvShow();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTvShow() async {
    try {
      final result = await remoteDataSource.getPopularTvShow();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getRecommendationTvShow(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTvShow() async {
    try {
      final result = await remoteDataSource.getTopRatedTvShow();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchList() async {
    final result = await localDataSource.getWatchlistTvShows();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchList(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchList(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTvShow(String query) async {
    try {
      final result = await remoteDataSource.searchTvShows(query);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
