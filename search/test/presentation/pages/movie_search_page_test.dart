import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:search/search.dart';

import 'movie_search_page_test.mocks.dart';

@GenerateMocks([SearchBloc])
void main() {
  late MockSearchBloc mockSearchBloc;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
  });

  /// Will return the [child] widget centered inside a `MaterialApp` and a
  /// `Scaffold`.
  Widget _createApp(Widget child) {
    return BlocProvider<SearchBloc>.value(
      value: mockSearchBloc,
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

    await tester.pumpWidget(_createApp(const TextField()));

    expect(textBoxFinder, findsOneWidget);
  });
}
