import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular/popular.dart';
import 'package:top_rated/top_rated.dart';

import 'core_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvOnTheAir,
  GetTvPopular,
  GetTvTopRated,
])
void main() {
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;
  late CoreTvBloc coreTvBloc;

  setUp(() {
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    coreTvBloc = CoreTvBloc(
      mockGetTvOnTheAir,
      mockGetTvPopular,
      mockGetTvTopRated,
    );
  });

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
    originCountry: const ['US'],
  );

  final tTvList = <Tv>[tTv];
  final tTvPopularList = <Tv>[tTv];
  final tTvTopRatedList = <Tv>[tTv];

  test('initial state should be empty', () {
    expect(coreTvBloc.state, CoreEmpty());
  });

  blocTest<CoreTvBloc, CoreState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvOnTheAir.execute()).thenAnswer((_) async => Right(tTvList));
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(tTvPopularList));
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(tTvTopRatedList));
      return coreTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedCore()),
    expect: () => [
      CoreLoading(),
      CoreTvHasData(tTvList, tTvPopularList, tTvTopRatedList),
    ],
    verify: (bloc) => verify(mockGetTvOnTheAir.execute()),
  );

  blocTest<CoreTvBloc, CoreState>(
    'should emits [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return coreTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedCore()),
    expect: () => [
      CoreLoading(),
      const CoreError('Server Failure'),
      const CoreTvHasData([], [], []),
    ],
    verify: (bloc) => verify(mockGetTvOnTheAir.execute()),
  );
}
