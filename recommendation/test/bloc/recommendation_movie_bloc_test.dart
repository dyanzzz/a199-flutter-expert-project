import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recommendation/domain/usecases/get_movie_recommendations.dart';
import 'package:recommendation/recommendation.dart';

import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMovieBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendation;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendation);
  });

  const tId = 1;
  final tMovies = <Movie>[];

  test('initial state should be empty', () {
    expect(recommendationMovieBloc.state, RecommendationEmpty());
  });

  blocTest<RecommendationMovieBloc, RecommendationState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationLoading(),
      RecommendationMovieHasData(tMovies),
    ],
    verify: (bloc) => verify(mockGetMovieRecommendation.execute(tId)),
  );

  blocTest<RecommendationMovieBloc, RecommendationState>(
    'should emits [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationLoading(),
      const RecommendationError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetMovieRecommendation.execute(tId)),
  );
}
