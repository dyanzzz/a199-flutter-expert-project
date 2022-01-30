import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'movie_watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieBloc])
void main() {
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUp(() {
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>.value(
      value: mockWatchlistMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistMovieBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistLoading()));
    when(mockWatchlistMovieBloc.state).thenReturn(WatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));
    await tester.pump();

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistMovieBloc.stream).thenAnswer(
        (_) => Stream.value(WatchlistMovieHasData(testMovieList)));
    when(mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) =>
        Stream.value(const WatchlistError('Error Message')));
    when(mockWatchlistMovieBloc.state)
        .thenReturn(const WatchlistError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
