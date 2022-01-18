import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';

import 'tv_search_page_test.mocks.dart';

@GenerateMocks([TvSearchNotifier])
void main() {
  late MockTvSearchNotifier mockTvSearchNotifier;

  setUp(() {
    mockTvSearchNotifier = MockTvSearchNotifier();
  });

  Widget _createApp(Widget child) {
    return ChangeNotifierProvider<TvSearchNotifier>.value(
      value: mockTvSearchNotifier,
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

    await tester.pumpWidget(_createApp(TextField()));

    expect(textBoxFinder, findsOneWidget);
  });
}
