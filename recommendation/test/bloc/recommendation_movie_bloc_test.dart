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
import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  GetMovieRecommendations,
])
void main() {
  late DetailMovieBloc movieBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieBloc = DetailMovieBloc(
      mockGetMovieDetail,
      mockGetWatchListStatus,
      mockGetMovieRecommendations,
    );
  });

  const tId = 1;
  final tMovies = <Movie>[];
  const tMoviesIsWatchlist = true;

  test('initial state should be empty', () {
    expect(movieBloc.state, DetailEmpty());
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
      return movieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetail(tId)),
    expect: () => [
      DetailLoading(),
      DetailMovieHasData(testMovieDetail, tMoviesIsWatchlist, tMovies),
    ],
    verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId)),
  );
}
