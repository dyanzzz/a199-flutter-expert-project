/* import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../core/test/dummy_data/dummy_object_tv.dart';
import 'tv_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetTvWatchlist])
void main() {
  late TvWatchlistNotifier provider;
  late MockGetTvWatchlist mockGetTvWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvWatchlist = MockGetTvWatchlist();
    provider = TvWatchlistNotifier(getTvWatchlist: mockGetTvWatchlist)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvWatchlist.execute())
        .thenAnswer((_) async => Right([testWatchlistTv]));
    // act
    await provider.fetchTvWatchlist();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.tvWatchlist, [testWatchlistTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvWatchlist.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchTvWatchlist();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
 */