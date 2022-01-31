import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recommendation/recommendation.dart';
import 'package:watchlist/watchlist.dart';

import '../../../core/test/dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  GetMovieRecommendations,
])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    detailMovieBloc = DetailMovieBloc(
      mockGetMovieDetail,
      mockGetWatchListStatus,
      mockGetMovieRecommendations,
    );
  });

  const tId = 1;

  final tMovie = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[testMovie];
  const tMoviesIsWatchlist = true;

  test('initial state should be empty', () {
    expect(detailMovieBloc.state, DetailEmpty());
  });

  blocTest<DetailMovieBloc, DetailState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => tMoviesIsWatchlist);
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));

      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetail(tId)),
    expect: () => [
      DetailLoading(),
      DetailMovieHasData(tMovie, tMoviesIsWatchlist, tMovies),
    ],
    verify: (bloc) => verify(mockGetMovieDetail.execute(tId)),
  );

  blocTest<DetailMovieBloc, DetailState>(
    'Should emit [Loading, Error] when data is gotten failed',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('')));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => tMoviesIsWatchlist);
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('')));

      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetail(tId)),
    expect: () => [
      DetailLoading(),
      const DetailError(''),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}
