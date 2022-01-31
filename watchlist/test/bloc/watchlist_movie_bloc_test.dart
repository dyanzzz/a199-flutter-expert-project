import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import 'watchlist_movie_bloc_test.mocks.dart';
import '../../../core/test/dummy_data/dummy_objects.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
      mockGetWatchlistMovies,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedWatchlistMovie()),
    expect: () => [
      WatchlistLoading(),
      WatchlistMovieHasData(tMovieList),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMovieBloc, WatchlistState>(
    'should emits [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedWatchlistMovie()),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  group('Watchlist status', () {
    blocTest<WatchlistMovieBloc, WatchlistState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tMovie.id))
            .thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistStatus(tMovie.id)),
      expect: () => [const GetWatchlistStatusData(true)],
    );
  });

  group('Save Watchlist', () {
    blocTest<WatchlistMovieBloc, WatchlistState>(
      'should execute save watchlist when function is called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail, 'add')),
      verify: (bloc) => mockSaveWatchlist.execute(testMovieDetail),
    );
  });

  group('Remove Watchlist', () {
    blocTest<WatchlistMovieBloc, WatchlistState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlist(testMovieDetail, 'remove')),
      verify: (bloc) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
    );
  });
}
