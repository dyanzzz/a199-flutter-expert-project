import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/bloc/watchlist_movie_bloc.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  DetailMovieBloc,
  WatchlistMovieBloc,
])
void main() {
  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUp(() {
    mockDetailMovieBloc = MockDetailMovieBloc();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailMovieBloc>.value(
      value: mockDetailMovieBloc,
      child: BlocProvider<WatchlistMovieBloc>.value(
        value: mockWatchlistMovieBloc,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  testWidgets(
    'should display proggress bar when movie and recommendation loading',
    (WidgetTester tester) async {
      when(mockDetailMovieBloc.stream)
          .thenAnswer((_) => Stream.value(DetailLoading()));
      when(mockDetailMovieBloc.state).thenReturn(DetailLoading());
      when(mockWatchlistMovieBloc.stream)
          .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(false)));
      when(mockWatchlistMovieBloc.state)
          .thenReturn(const GetWatchlistStatusData(false));

      final loadingFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(loadingFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when get data is error',
    (WidgetTester tester) async {
      when(mockDetailMovieBloc.stream)
          .thenAnswer((_) => Stream.value(const DetailError('Error Message')));
      when(mockDetailMovieBloc.state)
          .thenReturn(const DetailError('Error Message'));
      when(mockWatchlistMovieBloc.stream)
          .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(false)));
      when(mockWatchlistMovieBloc.state)
          .thenReturn(const GetWatchlistStatusData(false));

      final errorFinder = find.text('Error Message');

      await tester
          .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(errorFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailMovieBloc.stream).thenAnswer((_) => Stream.value(
        DetailMovieHasData(testMovieDetail, false, const <Movie>[])));
    when(mockDetailMovieBloc.state).thenReturn(
        DetailMovieHasData(testMovieDetail, false, const <Movie>[]));
    when(mockWatchlistMovieBloc.stream)
        .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(false)));
    when(mockWatchlistMovieBloc.state)
        .thenReturn(const GetWatchlistStatusData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailMovieBloc.stream).thenAnswer((_) => Stream.value(
        DetailMovieHasData(testMovieDetail, true, const <Movie>[])));
    when(mockDetailMovieBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail, true, const <Movie>[]));
    when(mockWatchlistMovieBloc.stream)
        .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(true)));
    when(mockWatchlistMovieBloc.state)
        .thenReturn(const GetWatchlistStatusData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
