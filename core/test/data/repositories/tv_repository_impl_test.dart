import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object_tv.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvModel = TvModel(
    backdropPath: "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
    firstAirDate: '2021-11-24',
    genreIds: [10759, 18],
    id: 88329,
    name: "Hawkeye",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Hawkeye",
    overview:
        "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
    popularity: 2203.365,
    posterPath: "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
    voteAverage: 8.5,
    voteCount: 1241,
  );

  final tTv = Tv(
    backdropPath: "/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg",
    firstAirDate: '2021-11-24',
    genreIds: [10759, 18],
    id: 88329,
    name: "Hawkeye",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Hawkeye",
    overview:
        "Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.",
    popularity: 2203.365,
    posterPath: "/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg",
    voteAverage: 8.5,
    voteCount: 1241,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('On The Air', () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(mockRemoteDataSource.getOnTheAirTvShow())
          .thenAnswer((realInvocation) async => []);
      //act
      await repository.getOnTheAirTvShow();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvShow())
            .thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.getOnTheAirTvShow();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvShow());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvShow())
            .thenAnswer((_) async => tTvModelList);
        // act
        await repository.getOnTheAirTvShow();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvShow());
        verify(mockLocalDataSource.cacheOnTheAirTvShow([testTvCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvShow())
            .thenThrow(ServerException());
        // act
        final result = await repository.getOnTheAirTvShow();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvShow());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        // arrange
        when(mockLocalDataSource.getCacheOnTheAirTvShow())
            .thenAnswer((_) async => [testTvCache]);
        // act
        final result = await repository.getOnTheAirTvShow();
        // assert
        verify(mockLocalDataSource.getCacheOnTheAirTvShow());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCacheOnTheAirTvShow())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getOnTheAirTvShow();
        // assert
        verify(mockLocalDataSource.getCacheOnTheAirTvShow());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Tv Show', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShow())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTvShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvShow();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvShow();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Show', () {
    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShow())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvShow();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Show Detail', () {
    final tId = 88329;
    final tTvResponse = TvDetailResponse(
      status: 'Ended',
      backdropPath: '/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg',
      genres: [GenreModel(id: 10759, name: 'Action & Adventure')],
      id: 88329,
      originalName: 'Hawkeye',
      overview:
          'Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.',
      posterPath: '/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg',
      firstAirDate: '2021-11-24',
      name: 'Hawkeye',
      voteAverage: 8.5,
      voteCount: 1267,
      inProduction: false,
      numberOfSeasons: 1,
      homepage: "https://www.disneyplus.com/series/hawkeye/11Zy8m9Dkj5l",
      lastAirDate: "2021-12-22",
      numberOfEpisodes: 6,
      originalLanguage: 'en',
      popularity: 1607.746,
      tagline: 'This holiday season, the best gifts come with a bow',
      type: 'Miniseries',
    );

    test(
        'should return tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getDetailTvShow(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getDetailTvShow(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetailTvShow(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 88329;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getRecommendationTvShow(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendationTvShow(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendationTvShow(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv Show', () {
    final tQuery = 'Hawkeye';

    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvShow(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchList(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchList(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchList(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchList(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of tv', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchList();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
