import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object_tv.dart';
import '../../../../test/helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watch list', () {
    test('should return success message when insert to database is success',
        () async {
      //arraneg
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistTv(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTv(testTvTable);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      //arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.removeWatchlistTv(testTvTable);
      //assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      //arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());
      //act
      final call = dataSource.removeWatchlistTv(testTvTable);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get tv detail by id', () {
    const id = 1;

    test('should return Tv Detail Table when data is found', () async {
      //arrange
      when(mockDatabaseHelper.getTvById(id)).thenAnswer((_) async => testTvMap);
      //act
      final result = await dataSource.getTvById(id);
      //assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      //arrange
      when(mockDatabaseHelper.getTvById(id)).thenAnswer((_) async => null);
      //act
      final result = await dataSource.getTvById(id);
      //assert
      expect(result, null);
    });
  });

  group('get watchlist tv show', () {
    test('should return list of TvTable from database', () async {
      //arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvMap]);
      //act
      final result = await dataSource.getWatchlistTvShows();
      //assert
      expect(result, [testTvTable]);
    });
  });

  group('cache on the air tv show', () {
    test('should call database helper to save data', () async {
      //arrange
      when(mockDatabaseHelper.clearCacheTv('on the air'))
          .thenAnswer((_) async => 1);
      //act
      await dataSource.cacheOnTheAirTvShow([testTvCache]);
      //assert
      verify(mockDatabaseHelper.clearCacheTv('on the air'));
      verify(mockDatabaseHelper
          .insertCacheTransactionTv([testTvCache], 'on the air'));
    });

    test('should return list of tv show from db when data exist', () async {
      //arrange
      when(mockDatabaseHelper.getCacheTvShows('on the air'))
          .thenAnswer((_) async => [testTvCacheMap]);
      //act
      final result = await dataSource.getCacheOnTheAirTvShow();
      //assert
      expect(result, [testTvCache]);
    });

    test('should throw CacheException when cace data is not exist', () async {
      //arrange
      when(mockDatabaseHelper.getCacheTvShows('on the air'))
          .thenAnswer((_) async => []);
      //act
      final call = dataSource.getCacheOnTheAirTvShow();
      //assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
