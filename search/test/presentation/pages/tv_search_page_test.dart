import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../../../core/test/dummy_data/dummy_object_tv.dart';
import 'tv_search_page_test.mocks.dart';

@GenerateMocks([SearchTvBloc])
void main() {
  late MockSearchTvBloc mockSearchBloc;

  setUp(() {
    mockSearchBloc = MockSearchTvBloc();
  });

  Widget _createApp(Widget child) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockSearchBloc,
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  testWidgets('page should display textbox to search tv',
      (WidgetTester tester) async {
    final textBoxFinder = find.byType(TextField);

    await tester.pumpWidget(_createApp(const TextField()));

    expect(textBoxFinder, findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockSearchBloc.stream)
        .thenAnswer((_) => Stream.value(SearchLoading()));
    when(mockSearchBloc.state).thenReturn(SearchLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createApp(TvSearchPage()));

    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockSearchBloc.stream)
        .thenAnswer((_) => Stream.value(SearchTvHasData(testTvList)));
    when(mockSearchBloc.state).thenReturn(const SearchTvHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createApp(TvSearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display error message when error',
      (WidgetTester tester) async {
    when(mockSearchBloc.stream)
        .thenAnswer((_) => Stream.value(const SearchError('Error Message')));
    when(mockSearchBloc.state).thenReturn(const SearchError('Error Message'));

    final emptyMessage = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_createApp(TvSearchPage()));

    expect(emptyMessage, findsOneWidget);
  });
}
