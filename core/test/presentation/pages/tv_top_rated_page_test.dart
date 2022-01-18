import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_top_rated_page_test.mocks.dart';

@GenerateMocks([TvTopRatedNotifier])
void main() {
  late MockTvTopRatedNotifier mockTvTopRatedNotifier;

  setUp(() {
    mockTvTopRatedNotifier = MockTvTopRatedNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvTopRatedNotifier>.value(
      value: mockTvTopRatedNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTvTopRatedNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvTopRatedPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTvTopRatedNotifier.state).thenReturn(RequestState.Loaded);
    when(mockTvTopRatedNotifier.tv).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TvTopRatedPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('page should display text with message when error',
      (WidgetTester tester) async {
    when(mockTvTopRatedNotifier.state).thenReturn(RequestState.Error);
    when(mockTvTopRatedNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvTopRatedPage()));

    expect(textFinder, findsOneWidget);
  });
}
