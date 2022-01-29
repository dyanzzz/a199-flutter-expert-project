import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvWatchlist,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetTvWatchlist mockGetTvWatchlist;
  late MockGetTvWatchListStatus mockGetWatchlistStatus;
  late MockSaveTvWatchlist mockSaveWatchlist;
  late MockRemoveTvWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvWatchlist = MockGetTvWatchlist();
    mockGetWatchlistStatus = MockGetTvWatchListStatus();
    mockSaveWatchlist = MockSaveTvWatchlist();
    mockRemoveWatchlist = MockRemoveTvWatchlist();

    watchlistTvBloc = WatchlistTvBloc(
      mockGetTvWatchlist,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  final tTv = Tv(
    backdropPath: '/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg',
    genreIds: const [14, 28],
    id: 88329,
    originalName: 'Hawkeye',
    overview:
        'Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.',
    popularity: 1607.746,
    posterPath: '/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg',
    name: 'Hawkeye',
    voteAverage: 8.5,
    voteCount: 1267,
    firstAirDate: '2021-11-24',
    originalLanguage: 'en',
    originCountry: const ['US'],
  );
  final tTvList = <Tv>[tTv];

  test('initial state should be empty', () {
    expect(watchlistTvBloc.state, WatchlistEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvWatchlist.execute())
          .thenAnswer((_) async => Right(tTvList));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetailTv()),
    expect: () => [
      WatchlistLoading(),
      WatchlistTvHasData(tTvList),
    ],
    verify: (bloc) => verify(mockGetTvWatchlist.execute()),
  );

  blocTest<WatchlistTvBloc, WatchlistState>(
    'should emits [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetTvWatchlist.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetailTv()),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTvWatchlist.execute()),
  );
}
