import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instock_mobile/src/features/business/screens/business_page.dart';

void main() {
  testWidgets('Business screen has Your Business heading', (tester) async {
    //Given
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BusinessPage()),
      ),
    );

    //When
    final yourBusinessFinder = find.text('Your Business');

    //Then
    expect(yourBusinessFinder, findsOneWidget);
  });
}