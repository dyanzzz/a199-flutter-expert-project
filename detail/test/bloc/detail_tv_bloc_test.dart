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
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvWatchListStatus,
  GetTvRecommendation,
])
void main() {
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockGetTvRecommendation mockGetTvRecommendation;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockGetTvRecommendation = MockGetTvRecommendation();
    detailTvBloc = DetailTvBloc(
      mockGetTvDetail,
      mockGetTvWatchListStatus,
      mockGetTvRecommendation,
    );
  });

  const tId = 88329;
  final testTvDetail = TvDetail(
    status: 'Ended',
    backdropPath: '/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg',
    genres: [Genre(id: 10759, name: 'Action & Adventure')],
    id: 88329,
    originalName: 'Hawkeye',
    overview:
        'Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.',
    posterPath: '/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg',
    firstAirDate: '2021-11-24',
    name: 'Hawkeye',
    voteAverage: 8.5,
    voteCount: 1267,
    inProduction: false,
    numberOfSeasons: 1,
    homepage: "https://www.disneyplus.com/series/hawkeye/11Zy8m9Dkj5l",
    lastAirDate: "2021-12-22",
    numberOfEpisodes: 6,
    originalLanguage: 'en',
    popularity: 1607.746,
    tagline: 'This holiday season, the best gifts come with a bow',
    type: 'Miniseries',
  );
  final tTvList = <Tv>[testTv];
  const tMoviesIsWatchlist = true;

  test('initial state should be empty', () {
    expect(detailTvBloc.state, DetailEmpty());
  });

  blocTest<DetailTvBloc, DetailState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvWatchListStatus.execute(tId))
          .thenAnswer((_) async => tMoviesIsWatchlist);
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tTvList));

      return detailTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetail(tId)),
    expect: () => [
      DetailLoading(),
      DetailTvHasData(testTvDetail, tMoviesIsWatchlist, tTvList),
    ],
    verify: (bloc) => verify(mockGetTvDetail.execute(tId)),
  );

  blocTest<DetailTvBloc, DetailState>(
    'Should emit [Loading, Error] when data is gotten failed',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('')));
      when(mockGetTvWatchListStatus.execute(tId))
          .thenAnswer((_) async => tMoviesIsWatchlist);
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('')));

      return detailTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedDetail(tId)),
    expect: () => [
      DetailLoading(),
      const DetailError(''),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
  );
}
