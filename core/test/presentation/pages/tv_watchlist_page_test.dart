import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_watchlist_page_test.mocks.dart';

@GenerateMocks([TvWatchlistNotifier])
void main() {
  late MockTvWatchlistNotifier mockTvWatchlistNotifier;

  setUp(() {
    mockTvWatchlistNotifier = MockTvWatchlistNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvWatchlistNotifier>.value(
      value: mockTvWatchlistNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockTvWatchlistNotifier.watchlistState)
        .thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvWatchlistPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('page should display listview when data is loaded',
      (WidgetTester tester) async {
    when(mockTvWatchlistNotifier.watchlistState)
        .thenReturn(RequestState.loaded);
    when(mockTvWatchlistNotifier.tvWatchlist).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvWatchlistPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('page should display text with message when error',
      (WidgetTester tester) async {
    when(mockTvWatchlistNotifier.watchlistState).thenReturn(RequestState.error);

    when(mockTvWatchlistNotifier.message).thenReturn('Error Message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvWatchlistPage()));

    expect(textFinder, findsOneWidget);
  });
}
