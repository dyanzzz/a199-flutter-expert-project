import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchBloc;
  late MockSearchTv mockSearch;

  setUp(() {
    mockSearch = MockSearchTv();
    searchBloc = SearchTvBloc(mockSearch);
  });

  final testTv = Tv(
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
  final tTvList = <Tv>[testTv];
  const tQuery = 'Hawkeye';
  const type = 'tv';

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  blocTest<SearchTvBloc, SearchState>(
    'should emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockSearch.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) => verify(mockSearch.execute(tQuery)),
  );

  blocTest<SearchTvBloc, SearchState>(
    'should emits [Loading, Error] when data is gotten unsuccessfully.',
    build: () {
      when(mockSearch.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) => verify(mockSearch.execute(tQuery)),
  );
}
