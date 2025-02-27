// Mocks generated by Mockito 5.0.17 from annotations
// in search/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;
import 'dart:convert' as _i7;
import 'dart:typed_data' as _i8;

import 'package:core/core.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvDetailResponse_2 extends _i1.Fake implements _i3.TvDetailResponse {
}

class _FakeResponse_3 extends _i1.Fake implements _i4.Response {}

class _FakeStreamedResponse_4 extends _i1.Fake implements _i4.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i3.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i5
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i5
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i5
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, _i3.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i3.Failure, _i3.MovieDetail>>.value(
              _FakeEither_0<_i3.Failure, _i3.MovieDetail>())) as _i5
          .Future<_i2.Either<_i3.Failure, _i3.MovieDetail>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i5
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i5
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, String>> saveWatchlist(
          _i3.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i3.Failure, String>>.value(
                  _FakeEither_0<_i3.Failure, String>()))
          as _i5.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, String>> removeWatchlist(
          _i3.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i3.Failure, String>>.value(
                  _FakeEither_0<_i3.Failure, String>()))
          as _i5.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i5.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>.value(
              _FakeEither_0<_i3.Failure, List<_i3.Movie>>())) as _i5
          .Future<_i2.Either<_i3.Failure, List<_i3.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i3.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i3.MovieModel>> getNowPlayingMovies() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]))
      as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<List<_i3.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]))
      as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<List<_i3.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]))
      as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i5.Future<_i3.MovieDetailResponse>);
  @override
  _i5.Future<List<_i3.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]))
          as _i5.Future<List<_i3.MovieModel>>);
  @override
  _i5.Future<List<_i3.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]))
          as _i5.Future<List<_i3.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i3.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> insertWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<String> removeWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<_i3.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i3.MovieTable?>.value())
          as _i5.Future<_i3.MovieTable?>);
  @override
  _i5.Future<List<_i3.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i3.MovieTable>>.value(<_i3.MovieTable>[]))
      as _i5.Future<List<_i3.MovieTable>>);
  @override
  _i5.Future<void> cacheNowPlayingMovies(List<_i3.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<List<_i3.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i3.MovieTable>>.value(<_i3.MovieTable>[]))
          as _i5.Future<List<_i3.MovieTable>>);
}

/// A class which mocks [TvRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRepository extends _i1.Mock implements _i3.TvRepository {
  MockTvRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>> getOnTheAirTvShow() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvShow, []),
              returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>.value(
                  _FakeEither_0<_i3.Failure, List<_i3.Tv>>()))
          as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>> getPopularTvShow() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShow, []),
              returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>.value(
                  _FakeEither_0<_i3.Failure, List<_i3.Tv>>()))
          as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>> getTopRatedTvShow() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShow, []),
              returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>.value(
                  _FakeEither_0<_i3.Failure, List<_i3.Tv>>()))
          as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, _i3.TvDetail>> getDetailTvShow(int? id) =>
      (super.noSuchMethod(Invocation.method(#getDetailTvShow, [id]),
              returnValue: Future<_i2.Either<_i3.Failure, _i3.TvDetail>>.value(
                  _FakeEither_0<_i3.Failure, _i3.TvDetail>()))
          as _i5.Future<_i2.Either<_i3.Failure, _i3.TvDetail>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>> getRecommendationTvShow(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getRecommendationTvShow, [id]),
              returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>.value(
                  _FakeEither_0<_i3.Failure, List<_i3.Tv>>()))
          as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>> searchTvShow(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShow, [query]),
              returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>.value(
                  _FakeEither_0<_i3.Failure, List<_i3.Tv>>()))
          as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, String>> saveWatchList(_i3.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchList, [tv]),
              returnValue: Future<_i2.Either<_i3.Failure, String>>.value(
                  _FakeEither_0<_i3.Failure, String>()))
          as _i5.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, String>> removeWatchList(
          _i3.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchList, [tv]),
              returnValue: Future<_i2.Either<_i3.Failure, String>>.value(
                  _FakeEither_0<_i3.Failure, String>()))
          as _i5.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i5.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>> getWatchList() =>
      (super.noSuchMethod(Invocation.method(#getWatchList, []),
              returnValue: Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>.value(
                  _FakeEither_0<_i3.Failure, List<_i3.Tv>>()))
          as _i5.Future<_i2.Either<_i3.Failure, List<_i3.Tv>>>);
}

/// A class which mocks [TvRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvRemoteDataSource extends _i1.Mock
    implements _i3.TvRemoteDataSource {
  MockTvRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i3.TvModel>> getOnTheAirTvShow() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvShow, []),
              returnValue: Future<List<_i3.TvModel>>.value(<_i3.TvModel>[]))
          as _i5.Future<List<_i3.TvModel>>);
  @override
  _i5.Future<List<_i3.TvModel>> getPopularTvShow() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShow, []),
              returnValue: Future<List<_i3.TvModel>>.value(<_i3.TvModel>[]))
          as _i5.Future<List<_i3.TvModel>>);
  @override
  _i5.Future<List<_i3.TvModel>> getTopRatedTvShow() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShow, []),
              returnValue: Future<List<_i3.TvModel>>.value(<_i3.TvModel>[]))
          as _i5.Future<List<_i3.TvModel>>);
  @override
  _i5.Future<_i3.TvDetailResponse> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue:
                  Future<_i3.TvDetailResponse>.value(_FakeTvDetailResponse_2()))
          as _i5.Future<_i3.TvDetailResponse>);
  @override
  _i5.Future<List<_i3.TvModel>> getTvRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvRecommendations, [id]),
              returnValue: Future<List<_i3.TvModel>>.value(<_i3.TvModel>[]))
          as _i5.Future<List<_i3.TvModel>>);
  @override
  _i5.Future<List<_i3.TvModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue: Future<List<_i3.TvModel>>.value(<_i3.TvModel>[]))
          as _i5.Future<List<_i3.TvModel>>);
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i3.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<String> insertWatchlistTv(_i3.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tv]),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<String> removeWatchlistTv(_i3.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tv]),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<_i3.TvTable?> getTvById(int? id) => (super.noSuchMethod(
      Invocation.method(#getTvById, [id]),
      returnValue: Future<_i3.TvTable?>.value()) as _i5.Future<_i3.TvTable?>);
  @override
  _i5.Future<List<_i3.TvTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<_i3.TvTable>>.value(<_i3.TvTable>[]))
          as _i5.Future<List<_i3.TvTable>>);
  @override
  _i5.Future<void> cacheOnTheAirTvShow(List<_i3.TvTable>? tv) =>
      (super.noSuchMethod(Invocation.method(#cacheOnTheAirTvShow, [tv]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<List<_i3.TvTable>> getCacheOnTheAirTvShow() =>
      (super.noSuchMethod(Invocation.method(#getCacheOnTheAirTvShow, []),
              returnValue: Future<List<_i3.TvTable>>.value(<_i3.TvTable>[]))
          as _i5.Future<List<_i3.TvTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i3.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i6.Database?> get database => (super.noSuchMethod(
      Invocation.getter(#database),
      returnValue: Future<_i6.Database?>.value()) as _i5.Future<_i6.Database?>);
  @override
  _i5.Future<void> insertCacheTransaction(
          List<_i3.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransaction, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i5.Future<List<Map<String, dynamic>>>);
  @override
  _i5.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<int> insertWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<int> removeWatchlist(_i3.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i5.Future<Map<String, dynamic>?>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i5.Future<List<Map<String, dynamic>>>);
  @override
  _i5.Future<void> insertCacheTransactionTv(
          List<_i3.TvTable>? tvMovies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransactionTv, [tvMovies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getCacheTvShows(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheTvShows, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i5.Future<List<Map<String, dynamic>>>);
  @override
  _i5.Future<int> clearCacheTv(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCacheTv, [category]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<int> insertWatchlistTv(_i3.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tv]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<int> removeWatchlistTv(_i3.TvTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tv]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<Map<String, dynamic>?> getTvById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i5.Future<Map<String, dynamic>?>);
  @override
  _i5.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i5.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i3.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_3()))
          as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_3()))
          as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_3()))
          as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_3()))
          as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_3()))
          as _i5.Future<_i4.Response>);
  @override
  _i5.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i7.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_3()))
          as _i5.Future<_i4.Response>);
  @override
  _i5.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<_i8.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i8.Uint8List>.value(_i8.Uint8List(0)))
          as _i5.Future<_i8.Uint8List>);
  @override
  _i5.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_4()))
          as _i5.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
