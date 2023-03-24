import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/stats/widgets/stats_box.dart';
import 'package:instock_mobile/src/theme/common_theme.dart';

void main() {
  testWidgets('Stats box displays data correctly', (tester) async {
    //Given
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: StatsBox(
          theme: CommonTheme(),
          stat: 'Orders',
          figure: 4,
        )),
      ),
    );

    //When
    final statFinder = find.text('Orders: 4');

    //Then
    expect(statFinder, findsOneWidget);
  });
}
