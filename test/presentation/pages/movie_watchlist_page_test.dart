import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'movie_watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier])
void main() {
  late MockWatchlistMovieNotifier mockWatchlistMovieNotifier;

  setUp(() {
    mockWatchlistMovieNotifier = MockWatchlistMovieNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistMovieNotifier>.value(
      value: mockWatchlistMovieNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistMovieNotifier.watchlistState)
        .thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('page should display listview when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistMovieNotifier.watchlistState)
        .thenReturn(RequestState.Loaded);
    when(mockWatchlistMovieNotifier.watchlistMovies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('page should display text with message when error',
      (WidgetTester tester) async {
    when(mockWatchlistMovieNotifier.watchlistState)
        .thenReturn(RequestState.Error);
    when(mockWatchlistMovieNotifier.message).thenReturn('Error Message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
