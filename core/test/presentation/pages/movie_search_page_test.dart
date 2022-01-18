import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import 'movie_search_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  late MockMovieSearchNotifier mockMovieSearchNotifier;

  setUp(() {
    mockMovieSearchNotifier = MockMovieSearchNotifier();
  });

  /// Will return the [child] widget centered inside a `MaterialApp` and a
  /// `Scaffold`.
  Widget _createApp(Widget child) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockMovieSearchNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  testWidgets('page should display textbox to search movie',
      (WidgetTester tester) async {
    final textBoxFinder = find.byType(TextField);

    await tester.pumpWidget(_createApp(TextField()));

    expect(textBoxFinder, findsOneWidget);
  });
}
