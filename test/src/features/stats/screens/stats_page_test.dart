import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/stats/screens/stats_page.dart';

void main() {
  testWidgets('Stats screen has Stats heading', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: StatsPage()),
      ),
    );

    //When
    final statsFinder = find.text('Stats');

    //Then
    expect(statsFinder, findsOneWidget);
  });
}
