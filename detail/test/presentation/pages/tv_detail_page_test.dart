import 'package:core/core.dart';
import 'package:detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../core/test/dummy_data/dummy_object_tv.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([
  DetailTvBloc,
  WatchlistTvBloc,
])
void main() {
  late MockDetailTvBloc mockDetailTvBloc;
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUp(() {
    mockDetailTvBloc = MockDetailTvBloc();
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailTvBloc>.value(
      value: mockDetailTvBloc,
      child: BlocProvider<WatchlistTvBloc>.value(
        value: mockWatchlistTvBloc,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  testWidgets(
    'should display proggress bar when tv and recommendation loading',
    (WidgetTester tester) async {
      when(mockDetailTvBloc.stream)
          .thenAnswer((_) => Stream.value(DetailLoading()));
      when(mockDetailTvBloc.state).thenReturn(DetailLoading());
      when(mockWatchlistTvBloc.stream)
          .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(false)));
      when(mockWatchlistTvBloc.state)
          .thenReturn(const GetWatchlistStatusData(false));

      final loadingFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
      expect(loadingFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should display error message when get data is error',
    (WidgetTester tester) async {
      when(mockDetailTvBloc.stream)
          .thenAnswer((_) => Stream.value(const DetailError('Error Message')));
      when(mockDetailTvBloc.state)
          .thenReturn(const DetailError('Error Message'));
      when(mockWatchlistTvBloc.stream)
          .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(false)));
      when(mockWatchlistTvBloc.state)
          .thenReturn(const GetWatchlistStatusData(false));

      final errorFinder = find.text('Error Message');

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
      expect(errorFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailTvBloc.stream).thenAnswer((_) =>
        Stream.value(DetailTvHasData(testTvDetail, false, const <Tv>[])));
    when(mockDetailTvBloc.state)
        .thenReturn(DetailTvHasData(testTvDetail, false, const <Tv>[]));
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(false)));
    when(mockWatchlistTvBloc.state)
        .thenReturn(const GetWatchlistStatusData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailTvBloc.stream).thenAnswer(
        (_) => Stream.value(DetailTvHasData(testTvDetail, true, const <Tv>[])));
    when(mockDetailTvBloc.state)
        .thenReturn(DetailTvHasData(testTvDetail, true, const <Tv>[]));
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(const GetWatchlistStatusData(true)));
    when(mockWatchlistTvBloc.state)
        .thenReturn(const GetWatchlistStatusData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
