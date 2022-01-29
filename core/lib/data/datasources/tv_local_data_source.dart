import 'package:core/core.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable tv);
  Future<String> removeWatchlistTv(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvShows();
  Future<void> cacheOnTheAirTvShow(List<TvTable> tv);
  Future<List<TvTable>> getCacheOnTheAirTvShow();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<void> cacheOnTheAirTvShow(List<TvTable> testTvTable) async {
    await databaseHelper.clearCacheTv('on the air');
    await databaseHelper.insertCacheTransactionTv(testTvTable, 'on the air');
  }

  @override
  Future<List<TvTable>> getCacheOnTheAirTvShow() async {
    final result = await databaseHelper.getCacheTvShows('on the air');
    if (result.isNotEmpty) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlistTv(TvTable testTvTable) async {
    try {
      await databaseHelper.insertWatchlistTv(testTvTable);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable testTvTable) async {
    try {
      await databaseHelper.removeWatchlistTv(testTvTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
