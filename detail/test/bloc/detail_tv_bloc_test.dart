import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:recommendation/recommendation.dart';
import 'package:watchlist/watchlist.dart';

import '../presentation/provider/tv_detail_notifier_test.mocks.dart';

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
    originCountry: ['US'],
  );
  final tTvList = <Tv>[tTv];

  test('initial state should be empty', () {
    expect(detailTvBloc.state, DetailEmpty());
  });
}
