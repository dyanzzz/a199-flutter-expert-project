import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recommendation/recommendation.dart';
import 'package:watchlist/watchlist.dart';

import '../../../core/test/dummy_data/dummy_object_tv.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvWatchListStatus,
  GetTvRecommendation,
])
void main() {
  late DetailTvBloc tvBloc;
  late MockGetTvDetail mockGetMovieDetail;
  late MockGetTvWatchListStatus mockGetWatchListStatus;
  late MockGetTvRecommendation mockGetTvRecommendation;

  setUp(() {
    mockGetMovieDetail = MockGetTvDetail();
    mockGetWatchListStatus = MockGetTvWatchListStatus();
    mockGetTvRecommendation = MockGetTvRecommendation();
    tvBloc = DetailTvBloc(
      mockGetMovieDetail,
      mockGetWatchListStatus,
      mockGetTvRecommendation,
    );
  });

  const tId = 1;
  final tTv = <Tv>[];
  const tTvIsWatchlist = true;

  test('initial state should be empty', () {
    expect(tvBloc.state, DetailEmpty());
  });

  blocTest<DetailTvBloc, DetailState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetWatchListStatus.execute(tId))
          .thenAnswer((_) async => tTvIsWatchlist);
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tTv));
      return tvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetail(tId)),
    expect: () => [
      DetailLoading(),
      DetailTvHasData(testTvDetail, tTvIsWatchlist, tTv),
    ],
    verify: (bloc) => verify(mockGetTvRecommendation.execute(tId)),
  );
}
