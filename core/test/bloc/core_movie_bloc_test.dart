import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular/domain/usecases/get_popular_movies.dart';
import 'package:top_rated/domain/usecases/get_top_rated_movies.dart';

import 'core_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late CoreMovieBloc coreMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    coreMovieBloc = CoreMovieBloc(
      mockGetNowPlayingMovies,
      mockGetPopularMovies,
      mockGetTopRatedMovies,
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
  final tMoviePopularList = <Movie>[tMovie];
  final tMovieTopRatedList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(coreMovieBloc.state, CoreEmpty());
  });

  blocTest<CoreMovieBloc, CoreState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMoviePopularList));
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieTopRatedList));
      return coreMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedCore()),
    expect: () => [
      CoreLoading(),
      CoreMovieHasData(tMovieList, tMoviePopularList, tMovieTopRatedList),
    ],
    verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
  );

  blocTest<CoreMovieBloc, CoreState>(
    'should emits [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return coreMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedCore()),
    expect: () => [
      CoreLoading(),
      const CoreError('Server Failure'),
      const CoreMovieHasData([], [], []),
    ],
    verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
  );
}
