/* import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:detail/detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recommendation/recommendation.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../core/test/dummy_data/dummy_object_tv.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendation,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendation mockGetTvRecommendation;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendation = MockGetTvRecommendation();
    mockGetTvWatchListStatus = MockGetTvWatchListStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendation: mockGetTvRecommendation,
      getTvWatchListStatus: mockGetTvWatchListStatus,
      saveTvWatchlist: mockSaveTvWatchlist,
      removeTvWatchlist: mockRemoveTvWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
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

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendation.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  group('Get tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendation.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tvRecommendations, tTvList);
    });
  });

  group('Get tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTvRecommendation.execute(tId));
      expect(provider.tvRecommendations, tTvList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.tvRecommendations, tTvList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadTvWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addTvWatchlist(testTvDetail);
      // assert
      verify(mockSaveTvWatchlist.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeTvFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveTvWatchlist.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addTvWatchlist(testTvDetail);
      // assert
      verify(mockGetTvWatchListStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addTvWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
 */