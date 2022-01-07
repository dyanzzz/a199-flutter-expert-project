import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_on_the_air.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvOnTheAir, GetTvPopular, GetTvTopRated])
void main() {
  late TvListNotifier provider;
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    provider = TvListNotifier(
      getTvOnTheAir: mockGetTvOnTheAir,
      getTvPopular: mockGetTvPopular,
      getTvTopRated: mockGetTvTopRated,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    backdropPath: '/1R68vl3d5s86JsS2NPjl8UoMqIS.jpg',
    genreIds: [14, 28],
    id: 88329,
    originalName: 'Hawkeye',
    overview:
        'Former Avenger Clint Barton has a seemingly simple mission: get back to his family for Christmas. Possible? Maybe with the help of Kate Bishop, a 22-year-old archer with dreams of becoming a superhero. The two are forced to work together when a presence from Barton’s past threatens to derail far more than the festive spirit.',
    popularity: 1607.746,
    posterPath: '/pqzjCxPVc9TkVgGRWeAoMmyqkZV.jpg',
    name: 'Hawkeye',
    voteAverage: 8.5,
    voteCount: 1267,
    firstAirDate: DateTime.parse('2021-11-24'),
    originalLanguage: 'en',
    originCountry: ['US'],
  );
  final tTvList = <Tv>[tTv];

  group('on the air tv show', () {
    test('initialState should be empty', () async {
      expect(provider.onTheAirTvShowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      //arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      //act
      provider.fetchTvOnTheAir();
      //assert
      verify(mockGetTvOnTheAir.execute());
    });

    test('should change state to Loading when usecase is called', () async {
      //arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      //act
      provider.fetchTvOnTheAir();
      //assert
      expect(provider.onTheAirTvShowsState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetTvOnTheAir.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvOnTheAir();
      // assert
      expect(provider.onTheAirTvShowsState, RequestState.Loaded);
      expect(provider.onTheAirTvShows, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvOnTheAir();
      // assert
      expect(provider.onTheAirTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv show', () {
    test('should change state to loading when usecase is called', () async {
      //arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      //act
      provider.fetchTvPopular();
      //assert
      expect(provider.popularTvShowsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetTvPopular.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvPopular();
      // assert
      expect(provider.popularTvShowsState, RequestState.Loaded);
      expect(provider.popularTvShows, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvPopular();
      // assert
      expect(provider.popularTvShowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTvTopRated();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvTopRated();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loaded);
      expect(provider.topRatedTvShows, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvTopRated();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
