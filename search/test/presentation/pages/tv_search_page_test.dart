import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:search/search.dart';

import 'tv_search_page_test.mocks.dart';

@GenerateMocks([SearchTvBloc])
void main() {
  late MockSearchTvBloc mockSearchTvBloc;

  setUp(() {
    mockSearchTvBloc = MockSearchTvBloc();
  });

  Widget _createApp(Widget child) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockSearchTvBloc,
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
}
