import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recommendation/domain/usecases/get_tv_recommendation.dart';
import 'package:recommendation/recommendation.dart';

import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendation])
void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTvRecommendation mockGetTvRecommendation;

  setUp(() {
    mockGetTvRecommendation = MockGetTvRecommendation();
    recommendationTvBloc = RecommendationTvBloc(mockGetTvRecommendation);
  });

  const tId = 1;
  final tTv = <Tv>[];

  test('initial state should be empty', () {
    expect(recommendationTvBloc.state, RecommendationEmpty());
  });

  blocTest<RecommendationTvBloc, RecommendationState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tTv));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationLoading(),
      RecommendationTvHasData(tTv),
    ],
    verify: (bloc) => verify(mockGetTvRecommendation.execute(tId)),
  );

  blocTest<RecommendationTvBloc, RecommendationState>(
    'should emits [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationLoading(),
      const RecommendationError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTvRecommendation.execute(tId)),
  );
}
