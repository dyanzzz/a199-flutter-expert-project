import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../core/test/dummy_data/dummy_object_tv.dart';
import 'tv_watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistTvBloc])
void main() {
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUp(() {
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistLoading()));
    when(mockWatchlistTvBloc.state).thenReturn(WatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvWatchlistPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('page should display listview when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvHasData(testTvList)));
    when(mockWatchlistTvBloc.state).thenReturn(WatchlistTvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvWatchlistPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('page should display text with message when error',
      (WidgetTester tester) async {
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(const WatchlistError('Error Message')));

    when(mockWatchlistTvBloc.state)
        .thenReturn(const WatchlistError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvWatchlistPage()));

    expect(textFinder, findsOneWidget);
  });
}
