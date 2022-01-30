import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:top_rated/top_rated.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMovieBloc])
void main() {
  late MockTopRatedMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TopRatedLoading()));
    when(mockBloc.state).thenReturn(TopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieHasData(testMovieList)));
    when(mockBloc.state).thenReturn(TopRatedMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(const TopRatedError('Error Message')));
    when(mockBloc.state).thenReturn(const TopRatedError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
