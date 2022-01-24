import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing Title MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      ),
    );
  });
}
